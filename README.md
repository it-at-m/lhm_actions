# LHM Actions

[![Made with love by it@M][made-with-love-shield]][itm-opensource]

<!-- feel free to add more shields, style 'for-the-badge' -> see https://shields.io/badges -->

This repository contains and provides:

- our global action definitions (see also workflows in [it-at-m/refarch-templates/](https://github.com/it-at-m/refarch-templates/tree/main/.github/workflows))

## Built With

The lhm_actions project is built with technologies we use in our projects:

- GitHub Actions

## Roadmap

See the [open issues](../../issues) for a full list of proposed features (and known issues).

## Set up

Feel free to use our actions in your project.

To start with actions read the [GitHub Actions documentation](https://github.com/features/actions)

## Documentation

We provide actions to

- Build Maven projects and deploy them to Maven Central
- Build npm projects and deploy them to npmjs
- Build Docker images and push them to GitHub Container Registry
- Create GitHub Releases

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please open an issue with the tag "enhancement", fork the repository and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Open an issue with the tag "enhancement"
2. Fork the Project
3. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
4. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
5. Push to the Branch (`git push origin feature/AmazingFeature`)
6. Open a Pull Request

More about this in the [CODE_OF_CONDUCT](/CODE_OF_CONDUCT.md) file.

## How to do a release?

We are using [semantic-release](https://github.com/semantic-release/semantic-release) to autogenerate releases. Before merging you need to add a prefix in the pull request title. [Details](https://github.com/semantic-release/semantic-release#commit-message-format)

- `fix:` for patch versions
- `feat:` for minor versions
- `perf:` for major versions - **Note**: When using squash merge, include `BREAKING CHANGE: description of breaking change` in the PR description body, which will be included in the squashed commit message.

## License

Distributed under the MIT License. See [LICENSE](LICENSE) file for more information.

## Contact

it@M - <opensource@muenchen.de>

<!-- project shields / links -->

[made-with-love-shield]: https://img.shields.io/badge/made%20with%20%E2%9D%A4%20by-it%40M-yellow?style=for-the-badge
[itm-opensource]: https://opensource.muenchen.de/
