FROM jupyter/datascience-notebook:lab-3.0.16
USER root
ENV DEBCONF_NOWARNINGS yes
RUN apt-get update
RUN apt-get install -y libpq-dev

ENV SHELL=/bin/bash \
    LC_ALL=ja_JP.UTF-8 \
    LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP.UTF-8

RUN  locale-gen $LC_ALL

USER jovyan
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade setuptools
RUN pip3 install --no-cache-dir ipython-sql==0.3.9
RUN pip3 install --no-cache-dir psycopg2==2.8.5
RUN pip3 install --no-cache-dir imblearn==0.0
RUN Rscript -e "install.packages(c('DBI', 'RPostgreSQL', 'rsample'), dependencies = TRUE, error = TRUE, repos='https://cran.r-project.org')"

RUN python3 -m pip install --upgrade setuptools pip wheel && pip install jupyterlab

# for rembg
RUN pip3 install torch==1.7.1+cpu torchvision==0.8.2+cpu -f https://download.pytorch.org/whl/torch_stable.html
RUN pip3 install --no-cache-dir rembg tqdm


# install the wheels we built in the first stage
# RUN mkdir -p /srv/jupyterhub/
# WORKDIR /srv/jupyterhub/

# # add config file
# COPY config/jupyterhub_config.py /srv/jupyterhub
# # COPY config/.zshrc ~

EXPOSE 8888

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"
LABEL org.jupyter.service="jupyterhub"

CMD ["jupyterhub"]
