# docker-scikit-learn
[![CircleCI](https://circleci.com/gh/smizy/docker-scikit-learn/tree/0.22.svg?style=svg&circle-token=0142f1f1188bf3bd4407cd860c1e8280f7315f60)](https://circleci.com/gh/smizy/docker-scikit-learn/tree/0.22)

Python3 scikit-learn with Jupyter docker image based on alpine 

## Supported tags and respective `Dockerfile` links

* [0.22.2.post1-alpine-r1, 0.22-alpine](https://github.com/smizy/docker-scikit-learn/blob/0.22/Dockerfile)

## Usage

```
# run Jupyter Notebook container (see token in log)
docker run -it --rm -p 8888:8888 -v $PWD:/code smizy/scikit-learn:0.22.2.post1-alpine-r1

# Or use PASSWORD environment variable instead of token
docker run  -p 8888:8888 -v $PWD:/code -e PASSWORD=yoursecretpass -d smizy/scikit-learn:0.22.2.post1-alpine-r1

# open browser
open http://$(docker-machine ip default):8888
```
