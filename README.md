# docker-scikit-learn
[![](https://images.microbadger.com/badges/image/smizy/scikit-learn:0.21.3-alpine.svg)](https://microbadger.com/images/smizy/scikit-learn:0.21.3-alpine "Get your own image badge on microbadger.com") 
[![](https://images.microbadger.com/badges/version/smizy/scikit-learn:0.21.3-alpine.svg)](https://microbadger.com/images/smizy/scikit-learn:0.21.3-alpine "Get your own version badge on microbadger.com")
[![CircleCI](https://circleci.com/gh/smizy/docker-scikit-learn/tree/0.21.svg?style=svg&circle-token=0142f1f1188bf3bd4407cd860c1e8280f7315f60)](https://circleci.com/gh/smizy/docker-scikit-learn/tree/0.21)

Python3 scikit-learn with Jupyter docker image based on alpine 

## Supported tags and respective `Dockerfile` links

* [0.21.3-alpine, 0.21-alpine, latest](https://github.com/smizy/docker-scikit-learn/blob/74246cd3645e8c782d1fdf8ea164edd2addfaa04/Dockerfile)
* [0.20.3-alpine, 0.20-alpine](https://github.com/smizy/docker-scikit-learn/blob/493de94a473993eb7346912c44e305a47a97f7f1/Dockerfile)

## Usage

```
# run Jupyter Notebook container (see token in log)
docker run -it --rm -p 8888:8888 -v $PWD:/code smizy/scikit-learn:0.21.3-alpine

# Or use PASSWORD environment variable instead of token
docker run  -p 8888:8888 -v $PWD:/code -e PASSWORD=yoursecretpass -d smizy/scikit-learn:0.21.3-alpine

# open browser
open http://$(docker-machine ip default):8888
```
