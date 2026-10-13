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

beipiel01
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

beipiel02
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

beipiel03
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

beipiel04
<!-- end-action-checkout -->

Executes the following steps:

1. Checkout current branch

Workflows using that action need the following permissions:

| Permission       | Purpose                      | Required |
| ---------------- | ---------------------------- | :------: |
| `contents: read` | Checkout repository contents |   Yes    |

<!-- start-action-dockercompose-healthcheck -->

beipiel05
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

beipiel06
<!-- end-action-filter -->

Executes the following steps:

1. Check changed files and directories

Workflows using that action need the following permissions:

| Permission            | Purpose                              |                                        Required                                         |
| --------------------- | ------------------------------------ | :-------------------------------------------------------------------------------------: |
| `contents: read`      | Checkout repository contents         | Optional. Necessary to detect changes against long-lived branches (main, releases etc.) |
| `pull-requests: read` | Ability to read pull request content |       Optional. Necessary to detect changes against the pull request base branch        |

<!-- start-action-codeql -->

beipiel07
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

beipiel08
<!-- end-action-create-github-release -->

Executes the following steps:

1. Download a single artifact
2. Create a GitHub release

Workflows using that action need the following permissions:

| Permission        | Purpose                   | Required |
| ----------------- | ------------------------- | :------: |
| `contents: write` | Create the GitHub Release |   Yes    |

<!-- start-action-dependency-review -->

beipiel09
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

beipiel10
<!-- end-action-deploy-docs -->

Executes the following steps:

1. Deploy docs to a web page

Workflows using that action need the following permissions:

| Permission        | Purpose                                                     | Required |
| ----------------- | ----------------------------------------------------------- | :------: |
| `pages: write`    | Deploy to GitHub Pages                                      |   Yes    |
| `id-token: write` | Verify the deployment originates from an appropriate source |   Yes    |

<!-- start-action-maven-build -->

beipiel11
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

beipiel12
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

beipiel13
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

beipiel14
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

beipiel15
<!-- end-action-pr-checklist -->

Workflows using that action do not require any explicit additional permissions.

<!-- start-action-pr-labeler -->

beipiel16
<!-- end-action-pr-labeler -->

Workflows using that action need the following permissions:

| Permission             | Purpose                      | Required |
| ---------------------- | ---------------------------- | :------: |
| `contents: read`       | Checkout repository contents |   Yes    |
| `pull-requests: write` | Add labels to pull requests  |   Yes    |
| `issues: write`        | Create labels if not exist   |   Yes    |

<!-- start-action-trivy -->

beipiel17
<!-- end-action-trivy -->

Workflows using that action need the following permissions:

| Permission               | Purpose                                                   | Required |
| ------------------------ | --------------------------------------------------------- | :------: |
| `contents: read`         | Checkout repository contents                              |   Yes    |
| `security-events: write` | Upload SARIF results to GitHub "Security and quality" tab |   Yes    |
