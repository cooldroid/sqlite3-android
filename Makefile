# http://www.sqlite.org/download.html
#SQLITE_VERSION  ?= 3110100
#SQLITE_DIST_EXT := zip

SQLITE_VERSION  ?= 201603160036
SQLITE_DIST_EXT := tar.gz

ifeq ($(strip $(SQLITE_DIST_EXT)),zip)
SQLITE_BASENAME := sqlite-amalgamation-$(SQLITE_VERSION)
SQLITE_URL      := http://www.sqlite.org/2016/$(SQLITE_BASENAME).$(SQLITE_DIST_EXT)
else
SQLITE_BASENAME := sqlite-snapshot-$(SQLITE_VERSION)
SQLITE_URL      := http://www.sqlite.org/snapshot/$(SQLITE_BASENAME).$(SQLITE_DIST_EXT)
endif

# Build/Compile
libs/armeabi/sqlite3-static: build/sqlite3.c
	ndk-build

# Unpack
build/sqlite3.c: $(SQLITE_BASENAME).$(SQLITE_DIST_EXT)
ifeq ($(strip $(SQLITE_DIST_EXT)),zip)
	unzip -oq "$<"
else
	tar -xf "$<"
endif
	rm -rf build
	mv "$(SQLITE_BASENAME)" build
	touch "$@"

# Download
$(SQLITE_BASENAME).$(SQLITE_DIST_EXT):
	curl -O "$(SQLITE_URL)"

clean:
	#rm -f "$(SQLITE_BASENAME).$(SQLITE_DIST_EXT)"
	rm -rf "$(SQLITE_BASENAME)"
	rm -rf build
	rm -rf obj
	rm -rf libs
