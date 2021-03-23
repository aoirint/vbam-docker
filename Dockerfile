# Common Build Arguments
ARG BASE_BUILD_IMAGE=nvidia/opengl:1.2-glvnd-devel-ubuntu18.04
ARG BASE_RUNTIME_IMAGE=nvidia/opengl:1.2-glvnd-runtime-ubuntu18.04


# Build
FROM ${BASE_BUILD_IMAGE} AS build-env
ARG VBAM_VERSION=e55ed5c0f49757652fbe0ee82e74da42e8e4d856
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /vbam_build

RUN apt-get update && \
    apt-get -y install \
        ca-certificates \
        tar \
        wget

# -- from builddeps script

# RUN apt-get update && \
#     apt-get -y install \
#         git \
#         build-essential \
#         nasm \
#         cmake \
#         ccache \
#         gettext \
#         zlib1g-dev \
#         libgl1-mesa-dev \
#         libavcodec-dev \
#         libavformat-dev \
#         libswscale-dev \
#         libavutil-dev \
#         libswresample-dev \
#         libgettextpo-dev \
#         libpng-dev \
#         libsdl2-dev \
#         libsdl2-2.0 \
#         libglu1-mesa-dev \
#         libglu1-mesa \
#         libgles2-mesa-dev \
#         libsfml-dev \
#         libsfml-graphics2.4 \
#         libsfml-network2.4 \
#         libsfml-window2.4 \
#         libglew2.0 \
#         libopenal-dev \
#         libwxgtk3.0-dev \
#         libwxgtk3.0 \
#         libgtk2.0-dev \
#         libgtk-3-dev \
#         zip

RUN apt-get update && \
    apt-get -y install \
        git \
        build-essential \
        nasm \
        cmake \
        ccache \
        gettext \
        zlib1g-dev \
        libgl1-mesa-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libavutil-dev \
        libswresample-dev \
        libgettextpo-dev \
        libpng-dev \
        libsdl2-dev \
        libglu1-mesa-dev \
        libgles2-mesa-dev \
        libsfml-dev \
        libopenal-dev \
        libwxgtk3.0-dev \
        libgtk2.0-dev \
        libgtk-3-dev

RUN git clone https://github.com/visualboyadvance-m/visualboyadvance-m.git . && \
    git checkout ${VBAM_VERSION}

RUN cmake . && \
    make -j"$(nproc)"

RUN make install DESTDIR=/vbam_install

  # runtime
FROM ${BASE_RUNTIME_IMAGE} AS runtime
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /vbam

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libwxgtk3.0 \
        libsdl2-2.0-0 \
        libsfml-graphics2.4 \
        libsfml-window2.4 \
        libsfml-network2.4 \
        libopenal1 \
        gosu

COPY --from=build-env /vbam_install /

ADD docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]
CMD [ "visualboyadvance-m" ]
