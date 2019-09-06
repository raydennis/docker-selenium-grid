ARG TARGET_HUB_VERSION=3.141.59
FROM selenium/hub:${TARGET_HUB_VERSION}-titanium

# ARG SERVICE_DIR="./workspace"
COPY ./.shared/scripts/ /tmp/scripts/
RUN sudo chmod +x -R /tmp/scripts/

# set timezone
ARG TZ=UTC
RUN sudo /tmp/scripts/set_timezone.sh ${TZ}

# install software
# RUN sudo /tmp/scripts/install-software.sh

# cleanup
# RUN sudo /tmp/scripts/cleanup.sh




