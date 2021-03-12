FROM node:12.14.0-alpine3.11

RUN apk add --no-cache bash

RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb

RUN sudo apt-get update
RUN sudo apt-get install esl-erlang
RUN sudo apt-get install elixir
RUN mix local.hex