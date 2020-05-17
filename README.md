This repository contains the build instructions to generate a docker image with various quality tools for PHP pre-installed


# Running in your CI/Cd

## Bitbucket Pipelines

```yml
- step:
    name: Run quality tools
    image: pnoexz/php-quality-tools:7.2
    script:
        - phplint
        - phpcs
```
