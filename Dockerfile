FROM debian

COPY . .

RUN bash build_from_source.sh
