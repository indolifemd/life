FROM        node:20-bullseye-slim

LABEL       author="indolifemd" maintainer="admin@indolife.shop"

# Install dependencies
RUN apt update && apt -y install --no-install-recommends \
        ffmpeg \
        iproute2 \
        git \
        sqlite3 \
        libsqlite3-dev \
        python3 \
        python3-dev \
        ca-certificates \
        dnsutils \
        tzdata \
        zip \
        tar \
        curl \
        build-essential \
        libtool \
        iputils-ping \
    && apt clean && rm -rf /var/lib/apt/lists/*

# Install npm and pm2 globally
RUN npm install npm@latest -g && npm install pm2 -g

# Add user
RUN useradd -m -d /home/container container

# Set environment and working directory
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

# Copy entrypoint script and ensure it's executable
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Default command
CMD [ "/bin/bash", "/entrypoint.sh" ]
