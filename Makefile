
.PHONY: all
all: runtime

.PHONY: clean
clean:
	docker rmi -f smizy/scikit-learn:${TAG} || :

.PHONY: runtime
runtime:
	docker build \
		--build-arg BUILD_DATE=${BUILD_DATE} \
		--build-arg VCS_REF=${VCS_REF} \
		--build-arg VERSION=${VERSION} \
		--rm -t smizy/scikit-learn:${TAG} .
	docker images | grep scikit-learn

.PHONY: test
test:
	bats test/test_*.bats