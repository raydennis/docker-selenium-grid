ARG TARGET_NODE_FIREFOX_VERSION=3.141.59
FROM selenium/node-firefox:${TARGET_NODE_FIREFOX_VERSION}-titanium

# ARG SERVICE_DIR="./workspace"
COPY ./.shared/scripts/ /tmp/scripts/
RUN sudo chmod +x -R /tmp/scripts/

# set timezone
ARG TZ=UTC
RUN sudo /tmp/scripts/set_timezone.sh ${TZ}

RUN sudo /tmp/scripts/cleanup.sh


