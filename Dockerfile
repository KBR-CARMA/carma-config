#  Copyright (C) 2018-2021 LEIDOS.
# 
#  Licensed under the Apache License, Version 2.0 (the "License"); you may not
#  use this file except in compliance with the License. You may obtain a copy of
#  the License at
# 
#  http://www.apache.org/licenses/LICENSE-2.0
# 
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#  WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#  License for the specific language governing permissions and limitations under
#  the License.

FROM arm64v8/busybox:latest
ARG CONFIG
ARG BUILD_DATE="NULL"
ARG VERSION="NULL"
ARG VCS_REF="NULL"
ARG CONFIG_NAME="carma-config:${CONFIG}"

# Metadata
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name=${CONFIG_NAME}
LABEL org.label-schema.description="System configuration data for the CARMA Platform"
LABEL org.label-schema.vendor="Leidos"
LABEL org.label-schema.version=${VERSION}
LABEL org.label-schema.url="https://highways.dot.gov/research/research-programs/operations/CARMA"
LABEL org.label-schema.vcs-url="https://github.com/usdot-fhwa-stol/carma-config"
LABEL org.label-schema.vcs-ref=${VCS_REF}
LABEL org.label-schema.build-date=${BUILD_DATE}

# Copy the vehicle calibration
RUN     mkdir -p /opt/carma  \
    &&  mkdir -p /opt/carma/vehicle/calibration \
    &&  mkdir -p /opt/carma/vehicle/config
COPY ./example_opt_carma/ /opt/carma/
COPY ./example_calibration_folder/vehicle/calibration/ /opt/carma/vehicle/calibration/
COPY ./${CONFIG}/* /opt/carma/vehicle/config/

# Fix permissions
RUN chown -R 1000:1000 /opt/carma

# Declare the volume
VOLUME /opt/carma/.ros
VOLUME /opt/carma/logs
VOLUME /opt/carma/maps
VOLUME /opt/carma/routes
VOLUME /opt/carma/vehicle
VOLUME /opt/carma/yolo
