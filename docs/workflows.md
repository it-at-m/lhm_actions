# Github Actions

We use Github-Actions to build our software. The costs are minimal because we use free and public repositories.

We designed templates to use GitHub Actions. The GitHub Action needs permission on the repository, for example, to create a release or push a tag. Here you can use automatic token authentication from GitHub. Therefore, you can use the access token via ${{ secrets.GITHUB_TOKEN }}. In contrast to the .gitlab-ci.yml, you can create more workflow files which are independent of each other. he it@M-Templates are flexibly designed to suit your project’s needs. You can create reusable actions for single steps.

The templates can be activated under the "Actions" tab with the "New workflow" button. In the software catalog, the templates can be found under the category "By it@m".

- **maven-node-nuild**: Executes “mvn install” for Maven projects or “npm run build” for Node.js projects. It selects a free version of OpenJDK and Node.js based on the presence of a pom.xml or package.json in the folder. Specify your subfolders if needed. After the source code is built, a “docker build” is executed, and the resulting Docker image is pushed to GitHub’s internal registry with the tag “latest”. Ensure that the Dockerfile is available in the folder.
- **maven-release**: This manual workflow requires you to navigate to the “actions” tab on the left and start the “maven-release” workflow using the “Run workflow” button at the top of the table. You can then select the desired version in the x.y.z format, followed by the corresponding SNAPSHOT-x.y.z. Manual configuration of write rights is not required.
  For the maven-release to work, reference the pom.xml as follows. Replace the placeholder variables with the actual values when pushing your artifact to Maven Central.

```xml
<scm>
        <connection>scm:git:${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}.git</connection>
        <developerConnection>scm:git:${GITHUB_SERVER_URL}/${GITHUB_REPOSITORY}.git</developerConnection>
      <tag>HEAD</tag>
  </scm>
```

- **npm-release**: This manual workflow is similar to Maven-Release, but for Node.js projects. It allows you to select the desired version, after which an npm release is performed and a Docker image is created.
- **codeql**: Workflow for advanced CodeQL setup used for scanning Java/JavaScript/TypeScript/Vue/Python based source files
- **deploy-docs**: This action publishes VitePress-generated documentation as GitHub Pages.
- **pr-checklist**: Checks if all list items are checked
- **pr-labeler**: This action labels prs
