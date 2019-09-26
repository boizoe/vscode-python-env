FROM python:3

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=1000

RUN groupadd --gid ${USER_GID} ${USERNAME} \
  && useradd --uid ${USER_UID} --gid ${USER_GID} -m -s /bin/bash ${USERNAME} \
  && mkdir -p /home/${USERNAME}/.vscode-server /home/${USERNAME}/.vscode-server-insiders \
  && chown ${USER_UID}:${USER_GID} /home/${USERNAME}/.vscode-server* \
  && sed -i 's/\#alias/alias/g' /home/${USERNAME}/.bashrc \
  && echo 'export PATH=${PATH}:${HOME}/.local/bin' >> /home/${USERNAME}/.bashrc

USER ${USERNAME}

RUN /usr/local/bin/python3 -m pip --no-cache-dir install --user -U pylint

EXPOSE 5000
