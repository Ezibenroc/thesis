FROM ezibenroc/orgmode_latex:latest

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN echo "TEST DOCKERHUB"
