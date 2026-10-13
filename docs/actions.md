# LHM Actions

[[toc]]

This repository contains and provides actions to

- Build Maven projects and deploy them to Maven Central
- Build npm projects and deploy them to npmjs
- Build Docker images and push them to GitHub Container Registry
- Create GitHub releases
- Build VitePress documentation and deploy it to GitHub Pages
- You can use CodeQL to identify vulnerabilities and errors in your code. The results are shown as code scanning alerts in GitHub.

## Usage

<!-- start-action-actionlint -->

<!-- markdownlint-disable -->
### action-actionlint

Action to lint your workflows using [actionlint](https://github.com/rhysd/actionlint)
No Inputs

No Outputs
<!-- markdownlint-enable -->
<!-- end-action-actionlint -->

Executes the following steps:

1. Checkout code
2. Run actionlint on your workflow files

Workflows using that action need the following permissions:

| Permission             | Purpose                                                      | Required |
| ---------------------- | ------------------------------------------------------------ | :------: |
| `contents: read`       | Checkout repository contents                                 |   Yes    |
| `pull-requests: write` | needed to annotate the files in a pull request with comments |   Yes    |

**Note**: The usage of `display-findings: true` requires additional setup.
See [actionlint documentation](https://github.com/rhysd/actionlint/blob/main/docs/usage.md#problem-matchers) for more information.

<!-- start-action-build-docs -->

<!-- markdownlint-disable -->
### action-build-docs

Build docs with VitePress or VuePress
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `docs-path` | Path to VitePress docs project | `./docs` | False |
| `node-version` | Node version. If node-version and node-version-file are both provided the action will use version from node-version. | n/a | False |
| `build-cmd` | Build command to run (e.g. for VuePress use: vuepress build) | `build` | False |
| `dist-path` | VitePress output path that will be uploaded as artifact. Output directory that will be uploaded to GitHub Pages | `.vitepress/dist` | False |
| `npm-ci-parameter` | disallow external scripts during npm ci <https://about.gitlab.com/blog/pipeline-security-lessons-from-march-supply-chain-incidents/#use-case-2-detect-dependency-tampering-and-lockfile-manipulation> | `--ignore-scripts` | False |

No Outputs
<!-- markdownlint-enable -->
<!-- end-action-build-docs -->

Executes the following steps:

1. Enables GitHub Pages
2. Build VitePress docs project
3. Uploads the build output as an artifact.<br/>
   The uploaded artifact can be used to deploy the docs to a web page (see [action-deploy-docs](#action-deploy-docs))

Workflows using that action need the following permissions:

| Permission       | Purpose                       | Required |
| ---------------- | ----------------------------- | :------: |
| `contents: read` | Checkout respository contents |   Yes    |

<!-- start-action-build-image -->

<!-- markdownlint-disable -->
### action-build-image

Action to build a multi-architecture Docker image with multi-architecture support and push it to a registry.
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `registry` | Image registry to push image to | `ghcr.io` | True |
| `registry-username` | Username to authenticate against image registry | n/a | True |
| `registry-password` | Password to authenticate against image registry | n/a | True |
| `image-tags` | Tags to tag image with | `type=raw,value=latest` | False |
| `image-labels` | Labels or OCI manifest annotations to add to image | `org.opencontainers.image.description=See ${{ github.server_url }}/${{ github.repository }}` | False |
| `path` | Path to the build context directory (containing the Dockerfile) | n/a | True |
| `image-name` | Name to give the image | n/a | True |
| `artifact-name` | Name of artifact to download  | n/a | True |
| `platforms` | List of comma separated Docker platforms to build images for, e.g. linux/amd64,linux/arm64. Note: This also requires a compatible base image in the Dockerfile of the application | `linux/amd64` | False |

No Outputs
<!-- markdownlint-enable -->
<!-- end-action-build-image -->

Executes the following steps:

1. Checkout code
2. Setup QEMU emulation to support multi-architecture builds
3. Setup buildx build tool
4. Login to Registry
5. Extract metadata (tags, labels, annotations) for Docker
6. Build and push image to a registry

Workflows using that action need the following permissions:

| Permission        | Purpose                             | Required |
| ----------------- | ----------------------------------- | :------: |
| `contents: read`  | Checkout repository contents        |   Yes    |
| `packages: write` | Pushes the image to GitHub Packages |   Yes    |

<!-- start-action-checkout -->

<!-- markdownlint-disable -->
### action-checkout

A wrapper for actions/checkout setting persist-credentials per default to false. using current branch with default values.
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `persist-credentials` | Whether to persist your credentials or not | `false` | False |

No Outputs
<!-- markdownlint-enable -->
<!-- end-action-checkout -->

Executes the following steps:

1. Checkout current branch

Workflows using that action need the following permissions:

| Permission       | Purpose                      | Required |
| ---------------- | ---------------------------- | :------: |
| `contents: read` | Checkout repository contents |   Yes    |

<!-- start-action-dockercompose-healthcheck -->

<!-- markdownlint-disable -->
### action-dockercompose-healthcheck

Validates a docker compose stack using its defined health checks
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `max-retries` | Maximum number of retry attempts | `10` | False |
| `retry-interval` | Interval between retries in seconds | `10` | False |
| `compose-file-path` | Path to the Docker compose file | `./` | False |
| `compose-file-name` | Name of the Docker compose file | `Docker-compose.yml` | False |
| `skip-exited` | Skip checking exited containers  (useful for init containers) | `false` | False |
| `skip-no-healthcheck` | Skip checking containers without health checks. Note: This applies to both persistent and existing containers. | `false` | False |

No Outputs
<!-- markdownlint-enable -->
<!-- end-action-dockercompose-healthcheck -->

Executes the following steps:

1. Start the Docker Compose stack
2. Run health check against the started services

Workflows using that action need the following permissions:

| Permission       | Purpose                      | Required |
| ---------------- | ---------------------------- | :------: |
| `contents: read` | Checkout repository contents |   Yes    |

**Note**: It is suggested to use images that provide a predefined health check.
Alternatively a [custom healthcheck](https://github.com/peter-evans/docker-compose-healthcheck) should be defined.
In some cases (e.g. when a barebone Unix image (like `alpine`) is used) health check might not be possible due to missing binaries
such as `wget` or `curl`. In this case `skip-no-healthcheck: true` can be used.

<!-- start-action-filter -->

<!-- markdownlint-disable -->
### action-filter

GitHub Action paths-filter with input of filters. It enables conditional execution of workflow steps and jobs, based on the files modified by pull request, on a feature branch, or by the recently pushed commits.
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `base` | Branch, tag, or commit SHA against which the changes will be detected. | "" | False |
| `filters` | Defines filters applied to detected changed files. Each filter has a name and a list of rules. Rule is a glob expression - paths of all changed files are matched against it. Rule can optionally specify if the file should be added, modified, or deleted. For each filter, there will be a corresponding output variable to indicate if there's a changed file matching any of the rules. Optionally, there can be a second output variable set to list of all files matching the filter. Filters can be provided inline as a string (containing valid YAML document), or as a relative path to a file (e.g.: .github/filters.yaml). Filters syntax is documented by example - see examples section. | `java:`<br>`  - '**/*.java'`<br>`javascript-typescript-vue:`<br>`  - '**/*.js'`<br>`  - '**/*.cjs'`<br>`  - '**/*.mjs'`<br>`  - '**/*.ts'`<br>`  - '**/*.cts'`<br>`  - '**/*.mts'`<br>`  - '**/*.vue'`<br>`python:`<br>`  - '**/*.py'`<br>`actions:`<br>`  - '.github/**/*.yml'`<br>`  - '.github/**/*.yaml'` | False |

| Ouputs | Description |
| :----- | :------- |
| `java` | Name of the Java artifact upload |
| `javascript-typescript-vue` | Name of the vue artifact upload |
| `python` | Name of the python artifact upload |
| `actions` | Whether an Actions or workflow file changed |
| `changes` | JSON array of filter names that have matched changes |
<!-- markdownlint-enable -->
<!-- end-action-filter -->

Executes the following steps:

1. Check changed files and directories

Workflows using that action need the following permissions:

| Permission            | Purpose                              |                                        Required                                         |
| --------------------- | ------------------------------------ | :-------------------------------------------------------------------------------------: |
| `contents: read`      | Checkout repository contents         | Optional. Necessary to detect changes against long-lived branches (main, releases etc.) |
| `pull-requests: read` | Ability to read pull request content |       Optional. Necessary to detect changes against the pull request base branch        |

<!-- start-action-codeql -->

<!-- markdownlint-disable -->
### action-codeql

Scans a repository using provided CodeQL language, buildmode and query scan set
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `codeql-language` | CodeQL language name to scan with (e.g java-kotlin, javascript-typescript, python, ...) | n/a | True |
| `codeql-buildmode` | Build mode to use when scanning the source code (e.g. none, autobuild, manual) | `none` | False |
| `codeql-query` | Query set to use when analyzing the source code (e.g. default, security-extended, security-and-quality) | `security-and-quality` | False |
| `java-version` | Temurin JDK version to use for autobuild (only when codeql-language is java-kotlin and codeql-build is set to autobuild). If not set extract the version from the `pom.xml` on the attribute `java.version`. | n/a | False |
| `path` | Path to scan files in | `.` | False |

No Outputs
<!-- markdownlint-enable -->
<!-- end-action-codeql -->

Executes the following steps:

1. Checkout repository
2. Setup JDK Version
3. Initialize CodeQL for language type
4. Build using Autobuild
5. Perform CodeQL analysis for language type

Workflows using that action need the following permissions:

| Permission               | Purpose                                                    | Required |
| ------------------------ | ---------------------------------------------------------- | :------: |
| `contents: read`         | Checkout repository contents                               |   Yes    |
| `security-events: write` | Report security problems (e.g. "Security and quality" tab) |   Yes    |

<!-- start-action-create-github-release -->

<!-- markdownlint-disable -->
### action-create-github-release

Creates a GitHub release from a downloaded artifact
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `artifact-name` | Name of the artifact to download | n/a | True |
| `tag-name` | Name of a tag (e.g. sps-1.0.0 or myproject-1.0.0) | n/a | True |
| `artifact-path` | Path to the artifacts (e.g. ./target/*.jar) | n/a | False |
| `draft` | Whether it is a draft release or not | `false` | False |
| `prerelease` | Whether it is a prerelease or not | `false` | False |
| `generate-release-notes` | Generate release notes | `false` | False |
| `skip-artifact-decompress` | Whether to skip decompressing a ZIP file (if detected). If true, the downloaded artifact will not be automatically extracted/decompressed. This is useful when you want to handle the artifact as-is without extraction. | `false` | False |

No Outputs
<!-- markdownlint-enable -->
<!-- end-action-create-github-release -->

Executes the following steps:

1. Download a single artifact
2. Create a GitHub release

Workflows using that action need the following permissions:

| Permission        | Purpose                   | Required |
| ----------------- | ------------------------- | :------: |
| `contents: write` | Create the GitHub Release |   Yes    |

<!-- start-action-dependency-review -->

<!-- markdownlint-disable -->
### action-dependency-review

The dependency review action scans your pull requests for dependency changes, and will raise an error if any invalid licenses are being used. It will always use the baseline configuration in <https://github.com/it-at-m/.github/blob/main/workflow-configs/dependency_review.yaml>. If you use the action with a matrix, you should watch that the path is different for each call.
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `allow-dependencies-licenses` | Additional comma separated string of packages to be ignored by the dependency check (see https://github.com/package-url/purl-spec for more information) | "" | False |
| `vulnerability-check` | Enables/Disables vulnerability scanning of dependencies | `false` | False |
| `allow-ghsas` | Additional comma separated string of GHSAs (see https://github.com/advisories) to be suppressed by the vulnerability check. For CVEs, the corresponding GHSA ID has to be used instead of directly using the CVE identifier. | "" | False |

No Outputs
<!-- markdownlint-enable -->
<!-- end-action-dependency-review -->

Executes the following steps:

1. Checkout repository
2. Execute dependency review check

Workflows using that action need the following permissions:

| Permission             | Purpose                       |                                             Required                                             |
| ---------------------- | ----------------------------- | :----------------------------------------------------------------------------------------------: |
| `contents: read`       | Checkout repository contents  |                                               Yes                                                |
| `pull-requests: write` | Write comment to pull request | Optional. Necessary, if configuration `comment-summary-in-pr` is set to `always` or `on-failure` |

<!-- start-action-deploy-docs -->

<!-- markdownlint-disable -->
### action-deploy-docs

Action to deploy a docs artifact to a web page.
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `artifact_name` | The name of the artifact to deploy | `github-pages` | False |
| `deploy-branch` | Branch to deploy documentation from | `main` | False |

No Outputs
<!-- markdownlint-enable -->
<!-- end-action-deploy-docs -->

Executes the following steps:

1. Deploy docs to a web page

Workflows using that action need the following permissions:

| Permission        | Purpose                                                     | Required |
| ----------------- | ----------------------------------------------------------- | :------: |
| `pages: write`    | Deploy to GitHub Pages                                      |   Yes    |
| `id-token: write` | Verify the deployment originates from an appropriate source |   Yes    |

<!-- start-action-maven-build -->

<!-- markdownlint-disable -->
### action-maven-build

Executes a Maven build and uploads the generated artifact to Maven Central
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `java-version` | Java version to use for the build. If not set extract the version from the `pom.xml` on the attribute `java.version`. | n/a | False |
| `app-path` | Path to the projects pom.xml file | n/a | True |

| Ouputs | Description |
| :----- | :------- |
| `artifact-name` | Name of the artifact upload |
| `cyclone-artifact-id` | ID of the sbom artifact |
| `sbom-path` | path of the sbom |
<!-- markdownlint-enable -->
<!-- end-action-maven-build -->

Executes the following steps:

1. Checkout repository
2. Setup Java version
3. Execute Maven build
4. Upload build artifact

Workflows using that action need the following permissions:

| Permission       | Purpose                      | Required |
| ---------------- | ---------------------------- | :------: |
| `contents: read` | Checkout repository contents |   Yes    |

<!-- start-action-maven-release -->

<!-- markdownlint-disable -->
### action-maven-release

Action to create a Maven release and deploy it to Maven Central.
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `java-version` | Java version to use for the build. If not set extract the version from the `pom.xml` on the attribute `java.version`. | n/a | False |
| `app-path` | Path to the projects pom.xml file | n/a | True |
| `release-method` | If releaseVersion is empty, the release version is taken from pom.xml without -SNAPSHOT. release-method calculates the next snapshot version: patch, minor, or major. Deprecated: If developmentVersion is set, it overrides the calculated snapshot version. | `patch` | False |
| `releaseVersion` | Version to be released. The value is calculated if release-method is set | "" | False |
| `developmentVersion` | Deprecated: Next version with snapshot | "" | False |
| `skipDeployment` | Deprecated: Use mavenDArgsInput instead. Skip deployment to Maven Central | `true` | False |
| `use-pr` | Use PR for version bump instead of direct push | `false` | False |
| `mavenDArgsInput` | Additional maven arguments. Example (skip unit tests, skip deployment) | "" | False |
| `GPG_PRIVATE_KEY` | Example (skip unit tests, skip deployment) | n/a | False |
| `SIGN_KEY_PASS` | Environment variable name for the GPG private key passphrase | n/a | False |
| `CENTRAL_USERNAME` | Environment variable name for the username for authentication to Maven Central | n/a | False |
| `CENTRAL_PASSWORD` | Environment variable name for password or token for authentication to Maven Central | n/a | False |

| Ouputs | Description |
| :----- | :------- |
| `MVN_ARTIFACT_ID` | Artifact name from pom |
| `artifact-name` | Name of the artifact upload |
| `release-version` | calculated release version |
<!-- markdownlint-enable -->
<!-- end-action-maven-release -->

Executes the following steps:

1. Checkout repository
2. Setup Java version
3. Execute Maven release and deploy it to Maven Central
4. Upload release artifact
5. Create PR for version bump (if enabled) using [peter-evans/create-pull-request](https://github.com/peter-evans/create-pull-request)

Workflows using that action need the following permissions:

| Permission             | Purpose                          |                             Required                             |
| ---------------------- | -------------------------------- | :--------------------------------------------------------------: |
| `contents: write`      | Change artifact's version number |                               Yes                                |
| `pull-requests: write` | Create a pull request            | Optional. Necessary if input parameter `use-pr` is set to `true` |

<!-- start-action-npm-build -->

<!-- markdownlint-disable -->
### action-npm-build

Executes an npm build and uploads the generated artifact to npm
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `node-version` | Node Version to use. If node-version and node-version-file are both provided the action will use version from node-version. | n/a | False |
| `app-path` | Path to package.json file | n/a | True |
| `run-lint` | Controls the execution of the 'npm run lint' script | `true` | False |
| `run-test` | Controls the execution of the 'npm run test' script | `true` | False |
| `npm-ci-parameter` | disallow external scripts during npm ci <https://about.gitlab.com/blog/pipeline-security-lessons-from-march-supply-chain-incidents/#use-case-2-detect-dependency-tampering-and-lockfile-manipulation> | `--ignore-scripts=true` | False |

| Ouputs | Description |
| :----- | :------- |
| `artifact-name` | Name of the artifact upload |
| `cyclone-artifact-id` | ID of the sbom artifact |
| `sbom-path` | path of the sbom |
<!-- markdownlint-enable -->
<!-- end-action-npm-build -->

Executes the following steps:

1. Checkout repository
2. Setup Node.js
3. Install dependencies
4. Run lint
5. Run test
6. Run build
7. Upload artifact

Workflows using that action need the following permissions:

| Permission       | Purpose                      | Required |
| ---------------- | ---------------------------- | :------: |
| `contents: read` | Checkout repository contents |   Yes    |

<!-- start-action-npm-release -->

<!-- markdownlint-disable -->
### action-npm-release

Action to create an npm release and deploy it to Node.js.
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `node-version` | Node Version to use. If node-version and node-version-file are both provided the action will use version from node-version. | n/a | False |
| `app-path` | Path to package.json file. would be equal to './package.json' and 'test-frontend' to './test-frontend/package.json' | n/a | True |
| `releaseVersion` | Level of release. Select version increment type (follows Semantic Versioning). Specifies how the version is increased. Options: patch, minor, major | n/a | True |
| `use-pr` | Use a PR for the version bump instead of directly pushing it | `false` | False |

| Ouputs | Description |
| :----- | :------- |
| `ARTIFACT_VERSION` | Version number of the artifact upload |
<!-- markdownlint-enable -->
<!-- end-action-npm-release -->

Executes the following steps:

1. Checkout repository
2. Setup Node.js version
3. Bump version and create Git tag
4. Create PR for version bump (if enabled) using [peter-evans/create-pull-request](https://github.com/peter-evans/create-pull-request)
5. Run npm build
6. Deploy npm artifact to Node.js

Workflows using that action need the following permissions:

| Permission             | Purpose                          |                             Required                             |
| ---------------------- | -------------------------------- | :--------------------------------------------------------------: |
| `contents: write`      | Change artifact's version number |                               Yes                                |
| `pull-requests: write` | Create a pull request            | Optional. Necessary if input parameter `use-pr` is set to `true` |

<!-- start-action-pr-checklist -->

<!-- markdownlint-disable -->
### action-pr-checklist

Action to enforce ticking of all checklist items inside a PR (useful for PR templates)
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `fail-missing` | Whether the action should fail if the PR contains no checklist | `false` | False |

No Outputs
<!-- markdownlint-enable -->
<!-- end-action-pr-checklist -->

Workflows using that action do not require any explicit additional permissions.

<!-- start-action-pr-labeler -->

<!-- markdownlint-disable -->
### action-pr-labeler

Action to automatically label pull requests using the configuration file in `.github/labeler.yml` of the repositories. More information about the configuration of the `labeler.yml` file can be found in [official documentation](https://github.com/actions/labeler)
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `configuration-path` | Path to the configuration file inside the repository | `.github/labeler.yml` | False |
| `repository` | Optional repository to checkout to reference external configuration file | "" | False |

No Outputs
<!-- markdownlint-enable -->
<!-- end-action-pr-labeler -->

Workflows using that action need the following permissions:

| Permission             | Purpose                      | Required |
| ---------------------- | ---------------------------- | :------: |
| `contents: read`       | Checkout repository contents |   Yes    |
| `pull-requests: write` | Add labels to pull requests  |   Yes    |
| `issues: write`        | Create labels if not exist   |   Yes    |

<!-- start-action-trivy -->

<!-- markdownlint-disable -->
### action-trivy

Action to run a security check with [Trivy](https://trivy.dev/latest/) on the Code.
| Input | Description | Default  | Required |
| :----- | :------- | :----- | :------ |
| `trivyignore-files` | Path(s) to .trivyignore file(s) to ignore known CVEs (comma- or newline-separated) | `.trivyignore` | False |
| `timeout` | Timeout for Trivy scan | `15m0s` | False |
| `path` | Path to scan with Trivy. For scan-type=sbom, this must point to a specific SBOM file (e.g. sbom.cdx.json), not a directory. | `.` | False |
| `scan-type` | scan type, e.g. fs or sbom | `fs` | False |

No Outputs
<!-- markdownlint-enable -->
<!-- end-action-trivy -->

Workflows using that action need the following permissions:

| Permission               | Purpose                                                   | Required |
| ------------------------ | --------------------------------------------------------- | :------: |
| `contents: read`         | Checkout repository contents                              |   Yes    |
| `security-events: write` | Upload SARIF results to GitHub "Security and quality" tab |   Yes    |




