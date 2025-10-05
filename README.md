# Arctyk Docs

[![Deploy Arctyk Docs](https://github.com/Arctyk-ITSM/arctyk-docs/actions/workflows/deploy.yml/badge.svg)](https://github.com/Arctyk-ITSM/arctyk-docs/actions/workflows/deploy.yml)
COLOR="blue"
[[ "$VERSION" == *alpha* ]] && COLOR="orange"
[[ "$VERSION" == *beta* ]] && COLOR="yellow"
[[ "$VERSION" == *rc* ]] && COLOR="lightgrey"
[[ "$VERSION" == [0-9]* ]] && COLOR="brightgreen"
BADGE_URL="https://img.shields.io/badge/docs-${VERSION// /%20}-${COLOR}"
[![Docs Online](https://img.shields.io/badge/docs-live-blue.svg)](https://arctyk-itsm.github.io/arctyk-docs/)

This repository contains the official documentation for **Arctyk ITSM**, a modular IT service management platform.

## Current Version
**v0.7.0-alpha.0**

## View the Documentation
[https://arctyk-itsm.github.io/arctyk-docs/](https://arctyk-itsm.github.io/arctyk-docs/)

## About
Arctyk ITSM is a modern, modular platform built with Django and designed for IT departments of all sizes.  

Documentation is managed using [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) and deployed automatically via GitHub Actions.

## Contributing
1. Clone this repo:
   ```bash
   git clone https://github.com/Arctyk-ITSM/arctyk-docs.git
   cd arctyk-docs
