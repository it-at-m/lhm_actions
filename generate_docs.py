"""
this modul generates the actions.md.
"""

import io
import os
import re

import yaml


def generate_markdown(action, path):
    """generates the project-docs"""
    with open(path, "r", encoding="utf-8") as file:
        daten = yaml.safe_load(file)
        builder = io.StringIO()
        builder.write("<!-- markdownlint-disable -->\n\n")
        # builder.write(f"# {daten['name']}\n")
        builder.write(f"### {action}\n\n")
        builder.write(f"{daten['description']}\n")
        if "inputs" not in daten:
            builder.write("No Inputs\n")
        else:
            builder.write("| Input | Description | Default  | Required |\n")
            builder.write("| :----- | :------- | :----- | :------ |\n")
            for item in daten["inputs"]:
                inputs = daten["inputs"][item]

                description = inputs["description"]
                required = inputs.get("required", "False")
                default = inputs.get("default", "n/a")
                default = default.removesuffix("\n")
                if default == "n/a":
                    default = "n/a"
                elif default == "":
                    default = '""'
                else:
                    default = f"`{default}`".replace("\n", "`<br>`")
                builder.write(
                    f"| `{item}` | {description} | {default} | {required} |\n"
                )

        builder.write("\n")
        if "outputs" not in daten:
            builder.write("No Outputs\n")
        else:
            builder.write("| Ouputs | Description |\n")
            builder.write("| :----- | :------- |\n")
            for item in daten["outputs"]:
                outputs = daten["outputs"][item]

                description = outputs["description"]

                builder.write(f"| `{item}` | {description} |\n")
        builder.write("\n")

        builder.write("Executes the following steps:\n\n")
        counter = 1
        for item in daten["runs"]["steps"]:
            builder.write(f"{counter}. {item['name']}\n")
            counter += 1
        builder.write("\n")

        builder.write("<!-- markdownlint-enable -->\n")
        final_string = builder.getvalue()
        builder.close()
        return final_string


def replace_table(pattern, content, new_table):
    """Search table with corresponding pattern and replace table."""
    match = re.search(pattern, content, re.DOTALL)

    if match:
        content_to_replace = match.group(1)
        content = content.replace(content_to_replace, new_table)
        return content

    raise RuntimeError(f"Wiki-table to update was not found with pattern: {pattern}")


def main():
    """main method"""
    path = "action-templates/actions"

    with open("docs/actions.md", "r", encoding="utf-8") as file:
        content = file.read()

    for element in os.listdir(path):
        replace = generate_markdown(element, f"{path}/{element}/action.yml")
        content = replace_table(
            rf"<!-- start-{element} -->\s*(.*?)<!-- end-{element} -->",
            content,
            replace,
        )
    print(content)


if __name__ == "__main__":
    main()
