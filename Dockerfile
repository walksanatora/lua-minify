#image that allows me to avoid having to download things twice
FROM archlinux:base-devel-20230108.0.116909 AS ccpc
RUN pacman-key --init
RUN pacman -Sy archlinux-keyring --noconfirm
RUN pacman -S --needed npm fish --noconfirm
RUN npm i -g luamin
COPY main.sh /main.sh
ENTRYPOINT ["/main.sh"]