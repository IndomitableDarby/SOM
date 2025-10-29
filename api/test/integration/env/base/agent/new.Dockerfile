FROM public.ecr.aws/o5x5t0j3/amd64/api_development:integration_test_som-generic

ARG SOM_BRANCH

## install som
RUN mkdir som && curl -sL https://github.com/som/som/tarball/${SOM_BRANCH} | tar zx --strip-components=1 -C som
ADD base/agent/preloaded-vars.conf /som/etc/preloaded-vars.conf
RUN /som/install.sh

COPY base/agent/entrypoint.sh /scripts/entrypoint.sh

HEALTHCHECK --retries=900 --interval=1s --timeout=40s --start-period=30s CMD /usr/bin/python3 /tmp_volume/healthcheck/healthcheck.py || exit 1
