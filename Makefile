BUILD_DIRS=build.*

all: release

system:
	./scripts/image

release:
	./scripts/image release

image:
	./scripts/image mkimage

clean:
	rm -rf $(BUILD_DIRS)/* $(BUILD_DIRS)/.stamps

distclean:
	rm -rf ./.ccache ./$(BUILD_DIRS)

src-pkg:
	tar cvjf sources.tar.bz2 sources .stamps
