# this file exists because Docker Hub can't make images out of build stages
# so this is a bit redundant with Dockerfile in this repo
# but it lets us host two images, mostly the same, on Hub

FROM jekyll/jekyll:3.8

WORKDIR /srv/jekyll
ENV TZ=America/Los_Angeles
ENV JEKYLL_GITHUB_TOKEN=${JEKYLL_GITHUB_TOKEN}
ENV FORCE_POLLING=true
ENV JEKYLL_ENV=${JEKYLL_ENV}

# RUN apk add --no-cache build-base gcc bash cmake git

# # install both bundler 1.x and 2.x
# RUN gem install bundler -v "~>1.0" && gem install bundler jekyll

RUN ln -s /srv/jekyll/src /srv/jekyll/docs

# Develop Tools
RUN apk update && apk add --no-cache curl zsh vim expect && apk upgrade
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/reobin/typewritten.git /root/.oh-my-zsh/custom/themes/typewritten
RUN ln -s "/root/.oh-my-zsh/custom/themes/typewritten/typewritten.zsh-theme" "/root/.oh-my-zsh/custom/themes/typewritten.zsh-theme"
ADD .devcontainer/.zshrc /root

EXPOSE 4000

ENTRYPOINT [ "jekyll" ]

RUN jekyll build

CMD [ "/bin/zsh" ]
# CMD [ "--help" ]
# CMD [ "jekyll", "serve", "--force_polling", "-H", "0.0.0.0", "-P", "4000" ]