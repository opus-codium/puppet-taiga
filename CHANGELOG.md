# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v4.1.0](https://github.com/opus-codium/puppet-taiga/tree/v4.1.0) (2025-04-28)

[Full Changelog](https://github.com/opus-codium/puppet-taiga/compare/v4.0.1...v4.1.0)

**Implemented enhancements:**

- Allow puppet/python 8.x [\#79](https://github.com/opus-codium/puppet-taiga/pull/79) ([smortex](https://github.com/smortex))
- Allow puppetlabs/vcsrepo 7.x [\#77](https://github.com/opus-codium/puppet-taiga/pull/77) ([smortex](https://github.com/smortex))
- Allow puppetlabs/postgresql 10.x [\#76](https://github.com/opus-codium/puppet-taiga/pull/76) ([smortex](https://github.com/smortex))
- Add support for FreeBSD 14 [\#74](https://github.com/opus-codium/puppet-taiga/pull/74) ([smortex](https://github.com/smortex))
- Add support for Debian 12 [\#73](https://github.com/opus-codium/puppet-taiga/pull/73) ([smortex](https://github.com/smortex))

**Fixed bugs:**

- Fix deployment with PostgreSQL 15 [\#75](https://github.com/opus-codium/puppet-taiga/pull/75) ([smortex](https://github.com/smortex))

## [v4.0.1](https://github.com/opus-codium/puppet-taiga/tree/v4.0.1) (2023-11-30)

[Full Changelog](https://github.com/opus-codium/puppet-taiga/compare/v4.0.0...v4.0.1)

**Fixed bugs:**

- Fix another non-namespaced `to_python` [\#70](https://github.com/opus-codium/puppet-taiga/pull/70) ([smortex](https://github.com/smortex))

## [v4.0.0](https://github.com/opus-codium/puppet-taiga/tree/v4.0.0) (2023-11-30)

[Full Changelog](https://github.com/opus-codium/puppet-taiga/compare/v3.1.0...v4.0.0)

**Breaking changes:**

- Prefer namespaced stdlib functions [\#68](https://github.com/opus-codium/puppet-taiga/pull/68) ([smortex](https://github.com/smortex))

## [v3.1.0](https://github.com/opus-codium/puppet-taiga/tree/v3.1.0) (2023-10-06)

[Full Changelog](https://github.com/opus-codium/puppet-taiga/compare/v3.0.0...v3.1.0)

**Implemented enhancements:**

- Allow management of Django's `ADMINS` setting [\#65](https://github.com/opus-codium/puppet-taiga/pull/65) ([smortex](https://github.com/smortex))

## [v3.0.0](https://github.com/opus-codium/puppet-taiga/tree/v3.0.0) (2023-08-08)

[Full Changelog](https://github.com/opus-codium/puppet-taiga/compare/v2.1.0...v3.0.0)

**Breaking changes:**

- Drop support for Debian 10 \(oldstable\) [\#58](https://github.com/opus-codium/puppet-taiga/pull/58) ([smortex](https://github.com/smortex))
- Remove support for Puppet 6 \(EOL\) [\#57](https://github.com/opus-codium/puppet-taiga/pull/57) ([smortex](https://github.com/smortex))
- Rework templates [\#51](https://github.com/opus-codium/puppet-taiga/pull/51) ([smortex](https://github.com/smortex))

**Implemented enhancements:**

- Add support for Puppet 8 [\#62](https://github.com/opus-codium/puppet-taiga/pull/62) ([smortex](https://github.com/smortex))
- Relax dependencies version requirements [\#60](https://github.com/opus-codium/puppet-taiga/pull/60) ([smortex](https://github.com/smortex))
- Allow puppetlabs-postgresql 8.x [\#55](https://github.com/opus-codium/puppet-taiga/pull/55) ([smortex](https://github.com/smortex))
- Add tasks to ease users/projects management [\#48](https://github.com/opus-codium/puppet-taiga/pull/48) ([neomilium](https://github.com/neomilium))

**Fixed bugs:**

- Fix deprecated usage of postgresql\_password [\#59](https://github.com/opus-codium/puppet-taiga/pull/59) ([smortex](https://github.com/smortex))

## [v2.1.0](https://github.com/opus-codium/puppet-taiga/tree/v2.1.0) (2021-10-24)

[Full Changelog](https://github.com/opus-codium/puppet-taiga/compare/2.0.1...v2.1.0)

**Implemented enhancements:**

- Add support for Debian 11 [\#50](https://github.com/opus-codium/puppet-taiga/pull/50) ([smortex](https://github.com/smortex))
- Add task to retrieve backend and frontend versions [\#46](https://github.com/opus-codium/puppet-taiga/pull/46) ([neomilium](https://github.com/neomilium))

**Fixed bugs:**

- Explicitely add directory entries for /media, /static [\#53](https://github.com/opus-codium/puppet-taiga/pull/53) ([smortex](https://github.com/smortex))

**Merged pull requests:**

- Allow stdlib 8.x [\#52](https://github.com/opus-codium/puppet-taiga/pull/52) ([smortex](https://github.com/smortex))

## [2.0.1](https://github.com/opus-codium/puppet-taiga/tree/2.0.1) (2021-05-14)

[Full Changelog](https://github.com/opus-codium/puppet-taiga/compare/2.0.0...2.0.1)

**Fixed bugs:**

- Fix CHANGELOG.md [\#45](https://github.com/opus-codium/puppet-taiga/pull/45) ([smortex](https://github.com/smortex))

## [2.0.0](https://github.com/opus-codium/puppet-taiga/tree/2.0.0) (2021-05-14)

[Full Changelog](https://github.com/opus-codium/puppet-taiga/compare/1.3.0...2.0.0)

**Breaking changes:**

- Relocate Taiga repositories [\#43](https://github.com/opus-codium/puppet-taiga/pull/43) ([smortex](https://github.com/smortex))
- Manage python through puppet-python [\#42](https://github.com/opus-codium/puppet-taiga/pull/42) ([smortex](https://github.com/smortex))

**Implemented enhancements:**

- Update dependencies [\#41](https://github.com/opus-codium/puppet-taiga/pull/41) ([smortex](https://github.com/smortex))

## [1.3.0](https://github.com/opus-codium/puppet-taiga/tree/1.3.0) (2021-03-15)

[Full Changelog](https://github.com/opus-codium/puppet-taiga/compare/1.2.0...1.3.0)

**Implemented enhancements:**

- Allow disabling inclusion of owner's username in projects slug [\#38](https://github.com/opus-codium/puppet-taiga/pull/38) ([smortex](https://github.com/smortex))

**Fixed bugs:**

- Fix string interpolation in configuration file [\#39](https://github.com/opus-codium/puppet-taiga/pull/39) ([smortex](https://github.com/smortex))

## [1.2.0](https://github.com/opus-codium/puppet-taiga/tree/1.2.0) (2021-02-09)

[Full Changelog](https://github.com/opus-codium/puppet-taiga/compare/1.1.0...1.2.0)

**Implemented enhancements:**

- Add support for Taiga 6.0.0 [\#33](https://github.com/opus-codium/puppet-taiga/pull/33) ([smortex](https://github.com/smortex))
- Add REFERENCE.md [\#31](https://github.com/opus-codium/puppet-taiga/pull/31) ([neomilium](https://github.com/neomilium))

**Fixed bugs:**

- Remove explicit data\_provider from metadata.json [\#34](https://github.com/opus-codium/puppet-taiga/pull/34) ([smortex](https://github.com/smortex))

## [1.1.0](https://github.com/opus-codium/puppet-taiga/tree/1.1.0) (2020-12-21)

[Full Changelog](https://github.com/opus-codium/puppet-taiga/compare/1.0.2...1.1.0)

**Implemented enhancements:**

- Fix comment in generated config file [\#27](https://github.com/opus-codium/puppet-taiga/pull/27) ([smortex](https://github.com/smortex))
- Add support for CHANGE\_NOTIFICATIONS\_MIN\_INTERVAL [\#26](https://github.com/opus-codium/puppet-taiga/pull/26) ([smortex](https://github.com/smortex))
- Rework Apache VirtualHost [\#23](https://github.com/opus-codium/puppet-taiga/pull/23) ([smortex](https://github.com/smortex))
- Modernize and add documentation [\#19](https://github.com/opus-codium/puppet-taiga/pull/19) ([smortex](https://github.com/smortex))
- Add support for Debian Buster [\#16](https://github.com/opus-codium/puppet-taiga/pull/16) ([smortex](https://github.com/smortex))
- Add data-types for all parameters [\#13](https://github.com/opus-codium/puppet-taiga/pull/13) ([smortex](https://github.com/smortex))

**Fixed bugs:**

- Fix install on Debian [\#21](https://github.com/opus-codium/puppet-taiga/pull/21) ([smortex](https://github.com/smortex))
- Fix missing migration dependency [\#17](https://github.com/opus-codium/puppet-taiga/pull/17) ([neomilium](https://github.com/neomilium))
- Fix seeding: there is no more initial\_role data to load [\#6](https://github.com/opus-codium/puppet-taiga/pull/6) ([neomilium](https://github.com/neomilium))

## [1.0.2](https://github.com/opus-codium/puppet-taiga/tree/1.0.2) (2017-04-05)

[Full Changelog](https://github.com/opus-codium/puppet-taiga/compare/1.0.1...1.0.2)

**Implemented enhancements:**

- Move Python parameters to param class [\#5](https://github.com/opus-codium/puppet-taiga/pull/5) ([smortex](https://github.com/smortex))
- Disable timeout for pip install [\#4](https://github.com/opus-codium/puppet-taiga/pull/4) ([smortex](https://github.com/smortex))
- Explicitely depend on passenger [\#3](https://github.com/opus-codium/puppet-taiga/pull/3) ([smortex](https://github.com/smortex))

## [1.0.1](https://github.com/opus-codium/puppet-taiga/tree/1.0.1) (2017-03-23)

[Full Changelog](https://github.com/opus-codium/puppet-taiga/compare/1.0.0...1.0.1)

**Implemented enhancements:**

- Add libssl-dev dependency on Debian [\#1](https://github.com/opus-codium/puppet-taiga/pull/1) ([smortex](https://github.com/smortex))

**Fixed bugs:**

- Ensure pip and setuptools are up-to-date [\#2](https://github.com/opus-codium/puppet-taiga/pull/2) ([smortex](https://github.com/smortex))

## [1.0.0](https://github.com/opus-codium/puppet-taiga/tree/1.0.0) (2016-10-14)

[Full Changelog](https://github.com/opus-codium/puppet-taiga/compare/55619003c02ae456d01a395540bd6675d8c60c8c...1.0.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
