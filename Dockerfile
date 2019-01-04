FROM ubuntu:trusty

ENV TERM=xterm-256color

# install python environment and mysql drivers
RUN apt-get update && \
    apt-get install -qy \
    -o APT::Install-Recommended=false -o APT::Install-Suggests=false \
    python python-virtualenv libpython2.7 python-mysqldb

# initialize virtual environment and update pip
RUN virtualenv /appenv && \
    . /appenv/bin/activate && \
    pip install pip --upgrade

# add entrypoint from scripts folder
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
