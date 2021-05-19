## Prisma precompiled builds for Raspberry Pi (armv7)

This repository contains precompiled [prisma-engines](https://github.com/prisma/prisma-engines) for Raspberry Pi.

## How to use this repository

1. Download all 4 Engine files from GitHub releases: https://github.com/pantharshit00/prisma-rpi-builds/releases
  - Optionally you can also download the shared `.so` Node API library
2. Extract these engines to a folder
3. Set the following environment variables in your shell or in the `.env` file:

  ```sh
  PRISMA_QUERY_ENGINE_BINARY=/path/to/query-engine
  PRISMA_MIGRATION_ENGINE_BINARY=/path/to/migration-engine
  PRISMA_INTROSPECTION_ENGINE_BINARY=/path/to/introspection-engine
  PRISMA_FMT_BINARY=/path/to/prisma-fmt
  # use following library only when using Node API integration
  PRISMA_QUERY_ENGINE_LIBRARY=/path/to/libquery_engine_napi.so
  ```

4. You are now ready to use Prisma on your Raspberry Pi.

## Additional notes

CI in this repository checks for a new major Prisma version everyday and if there is a new release avaliable, it will automatically build the engines and make a new release.
