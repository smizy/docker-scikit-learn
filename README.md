# docker-scikit-learn
[![](https://images.microbadger.com/badges/image/smizy/scikit-learn.svg)](https://microbadger.com/images/smizy/scikit-learn "Get your own image badge on microbadger.com") 
[![](https://images.microbadger.com/badges/version/smizy/scikit-learn.svg)](https://microbadger.com/images/smizy/scikit-learn "Get your own version badge on microbadger.com")
[![CircleCI](https://circleci.com/gh/smizy/docker-scikit-learn.svg?style=svg&circle-token=0142f1f1188bf3bd4407cd860c1e8280f7315f60)](https://circleci.com/gh/smizy/docker-scikit-learn)

Python3 scikit-learn with Jupyter docker image based on alpine 


```
# run Jupyter Notebook container 
docker run  -p 8888:8888 -v $(pwd):/code  -d smizy/scikit-learn

# open browser
open http://$(docker-machine ip default):8888
```
