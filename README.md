# meta

Reusable GitHub Actions workflows.

## Release Please

Add `.github/release-please-config.json` and `.github/release-please-manifest.json`
to the calling repository. Set `release-type` for each package in the config
file; the reusable workflow reads both files from the caller's checkout.

```yaml
name: Release

on:
  push:
    branches:
    - main

jobs:
  release:
    permissions:
      contents: write
      pull-requests: write
    uses: unfunco/meta/.github/workflows/release-please.yaml@main
```

## License

© 2026 [Daniel Morris]\
Made available under the terms of the [MIT License].

[daniel morris]: https://unfun.co
[mit license]: LICENSE.md
