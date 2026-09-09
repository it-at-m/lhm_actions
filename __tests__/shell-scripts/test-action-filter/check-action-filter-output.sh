          echo "action-filter output: $CATEGORIES"

          # remove "[" and "]"
          CATEGORIES=${CATEGORIES#[}
          CATEGORIES=${CATEGORIES%]}

          # remove quota
          CATEGORIES=${CATEGORIES//\"/}

          # convert CATEGORIES into an Array (based on comma) named category_list
          IFS=',' read -ra category_list <<< "$CATEGORIES"

          num_categories=${#category_list[@]}
          echo "Number of categories found with action-filter: $num_categories"

          # Activate globstar for pattern match
          shopt -s globstar

          # check each category only once
          action_found=0
          java_found=0
          markdown_found=0

          for category in "${category_list[@]}"; do
            case "$category" in
              "actions")
                 if [[ $action_found -eq 0 ]]; then
                   action_found=$((++action_found))
                 fi
                ;;
              "java")
                 if [[ $java_found -eq 0 ]]; then
                   java_found=$((++java_found))
                 fi
                ;;
              "markdown")
                 if [[ $markdown_found -eq 0 ]]; then
                   markdown_found=$((++markdown_found))
                 fi
                ;;
              *)
                # There shouldn't be any other categories
                echo "Category $category not allowed"
                exit 1
                ;;
            esac
          done

          # get all changed files (diff_ouptut.txt contains only filenames)
          if [[ -n "$BASE_BRANCH" ]]; then
            # Pull requests check against base branch
            echo "diff --name-only $BASE_BRANCH $CURRENT_BRANCH"
            git diff --name-only "$BASE_BRANCH" "$CURRENT_BRANCH" > diff_output.txt
          elif git rev-parse --verify "$SHA"^ > /dev/null 2>&1; then
            # Push requests check against previous commit of current SHA
            echo "diff --name-only $SHA^ $SHA"
            git diff --name-only "$SHA"^ "$SHA" > diff_output.txt
          else
            # no previous commit, e.g. initial commit
            echo "diff --name-only $SHA"
            git diff --name-only "$SHA" > diff_output.txt
          fi

          echo "Changed files:"
          cat diff_output.txt

          # List to add all categories found
          categories_found=()

          # Loop through all files
          while IFS= read -r filename; do
            echo "Changed file: $filename"

            if [[ "$filename" == .github/**/*.yml ]] || \
               [[ "$filename" == .github/**/*.yaml ]] || \
               [[ "$filename" == action-templates/**/*.yml ]] || \
               [[ "$filename" == action-templates/**/*.yaml ]]; then

              category="actions"

              echo "File for $category pattern found."
              if [[ $action_found -eq 0 ]]; then
                echo "File with pattern $category found but $category not set in action-filter!"
                exit 1
              fi

              # Add category "actions" to categories_found
              if [[ ! "${categories_found[*]}" =~ ${category} ]]; then
                categories_found+=("$category")
                echo "$category added to found categories."
              fi

            elif [[ "$filename" == **/*.java ]]; then

              category="java"

              echo "File for $category pattern found."
              if [[ $java_found -eq 0 ]]; then
                echo "File with pattern $category found but $category not set in action-filter!"
                exit 1
              fi

              # Add category "java" to categories_found
              if [[ ! "${categories_found[*]}" =~ ${category} ]]; then
                categories_found+=("$category")
                echo "$category added to found categories."
              fi

            elif [[ "$filename" == **/*.md ]]; then

              category="markdown"

              echo "File for $category pattern found."
              if [[ $markdown_found -eq 0 ]]; then
                echo "File with pattern $category found but $category not set in action-filter!"
                exit 1
              fi

              # Add category "markdown" to categories_found
              if [[ ! "${categories_found[*]}" =~ ${category} ]]; then
                categories_found+=("$category")
                echo "$category added to found categories."
              fi

            else
              # Filename doesn't follow any category
              echo "Filename $filename doesn't follow any pattern"
            fi

          done < diff_output.txt

          num_categories_found=${#categories_found[@]}

          # Check if all categories were found
          if [[ "$num_categories" -ne "$num_categories_found" ]]; then
            echo "Expected num_categories found equals to $num_categories but was $num_categories_found"
            exit 1
          fi

          echo "Test of action-filter ok"
