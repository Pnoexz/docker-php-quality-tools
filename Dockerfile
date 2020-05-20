###########################
FROM php:7.2-alpine AS base
###########################
WORKDIR /tmp

#########################
FROM base AS dependencies
#########################
RUN apk add composer git

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp

RUN composer require --no-progress --no-scripts --no-plugins --no-interaction \
    php "7.2.*" \
    overtrue/phplint \
    squizlabs/php_codesniffer \
    phpstan/phpstan \
    vimeo/psalm \
    phploc/phploc \
    nunomaduro/phpinsights \
    slevomat/coding-standard \
    phpcompatibility/php-compatibility

##################
FROM base AS final
##################
COPY --from=dependencies /tmp/vendor /composer/vendor
ENV PATH="/composer/vendor/bin:${PATH}"

RUN /composer/vendor/bin/phpcs --config-set installed_paths /composer/vendor/phpcompatibility/php-compatibility

WORKDIR /app
ENTRYPOINT ["/bin/sh", "-c"]
