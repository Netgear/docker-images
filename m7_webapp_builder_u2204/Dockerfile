# Use the official Ubuntu 22.04 image
FROM amd64/ubuntu:22.04
LABEL maintainer="lpacyk@netgear.com"

# Default username
ENV USERNAME="webapp_builder"

# Set the environment variables for non-interactive installation
ENV WORKSPACE=/ws

# Install Apt dependencies
RUN DEBIAN_FRONTEND=noninteractive apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y \
        sudo vim gosu git build-essential ca-certificates curl perl libxml-libxml-perl \
        mtd-utils gettext libxml2-dev zlib1g-dev openjdk-11-jdk locales locales-all && \
    apt clean && rm -rf /var/cache/apt/lists

# Add ZScaler CA Certificate to container
ADD ./files/ZscalerRootCertificate-2048-SHA256.crt /tmp/ZscalerRootCertificate-2048-SHA256.crt

# Install ZScaler CA Certificate
RUN CERT_DIR=/usr/local/share/ca-certificates && \
    cp /tmp/ZscalerRootCertificate-2048-SHA256.crt "$CERT_DIR" && \
    update-ca-certificates

# Install Node 8
RUN curl -LO https://nodejs.org/dist/v8.17.0/node-v8.17.0-linux-x64.tar.xz && \
    tar -xf node-v8.17.0-linux-x64.tar.xz && \
    cp -r node-v8.17.0-linux-x64/bin /usr/      && \
    cp -r node-v8.17.0-linux-x64/include /usr/  && \
    cp -r node-v8.17.0-linux-x64/lib /usr/      && \
    cp -r node-v8.17.0-linux-x64/share /usr/    && \
    rm -rf node-v8.17.0-linux-x64 node-v8.17.0-linux-x64.tar.xz && \
    node --version

# Install Perl Packages
RUN cpan File::Slurp XML::LibXML Locale::gettext Locale::Messages Locale::TextDomain Text::ParseWords

# Required for Webapp Perl localization scripts
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Set working directory
WORKDIR $WORKSPACE

# Create group and user
RUN groupadd -r ${USERNAME} && \
    useradd -d ${WORKSPACE} -g ${USERNAME} ${USERNAME} && \
    chown ${USERNAME}:${USERNAME} ${WORKSPACE}

# Run entrypoint script as root
USER root

# Set entry point
COPY ./files/docker-entrypoint.sh /ws/docker-entrypoint.sh
ENTRYPOINT ["/ws/docker-entrypoint.sh"]
