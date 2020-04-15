FROM archlinux

LABEL maintainer="skain80@gmail.com"
LABEL version="1.0"

RUN useradd -m build; \
    curl -s "https://www.archlinux.org/mirrorlist/?country=GB&protocol=https&use_mirror_status=on" \
    | grep Server | sed -e 's/^#Server/Server/' > /etc/pacman.d/mirrorlist; \
    pacman --noconfirm -Suy git base-devel; \
    echo MAKEFLAGS="-j$(nproc --ignore=1)" >> /etc/makepkg.conf; \
    echo "build ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers;

USER build
WORKDIR /home/build
RUN mkdir artifacts; \
    git clone https://aur.archlinux.org/yay.git; cd yay; \
    makepkg -si --noconfirm
RUN yay -S --noconfirm \
    meson \
    glslang
RUN yay -S --noconfirm \
    mingw-w64-headers-bin \
    mingw-w64-crt-bin \
    mingw-w64-binutils-bin \
    mingw-w64-winpthreads-bin \
    mingw-w64-gcc-bin && \
    yay -c --noconfirm && \
    rm -rf .cache

COPY build.sh /home/build/

RUN sudo chmod +x /home/build/build.sh

VOLUME ["/home/build/artifacts"]

CMD ["./build.sh"]
