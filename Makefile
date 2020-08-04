
BIN=GetArgs
DST=bin
GOARCH=amd64
#FLAGS_WIN=-ldflags='-H windowsgui -w -s -extldflags "-static"' -a -tags netgo -installsuffix netgo
FLAGS_WIN=-ldflags='-w -s -extldflags "-static"' -a -tags netgo -installsuffix netgo
FLAGS=-ldflags='-w -s -extldflags "-static"' -a -tags netgo -installsuffix netgo

.PHONY: build
build:
	mkdir -p ./$(DST)
ifeq ($(shell uname -o),Msys)
	go build -o ./$(DST)/$(BIN).exe
else
	go build -o ./$(DST)/$(BIN)
endif
#	cp -rf ./$(DST)/$(BIN) ..

all: build

release-build:
	GOARCH=$(GOARCH) GOOS=windows go build -o ./$(DST)/$(BIN)_windows.exe $(FLAGS_WIN)
	GOARCH=$(GOARCH) GOOS=darwin go build -o ./$(DST)/$(BIN)_macOS $(FLAGS)
	GOARCH=$(GOARCH) GOOS=linux go build -o ./$(DST)/$(BIN)_linux $(FLAGS)

release:
	make release-build
	make release-for-windows
	make release-for-mac
	make release-for-linux
	make release-clean

release-for-windows:
	mv ./$(DST)/$(BIN)_windows.exe ./$(DST)/$(BIN).exe
	cd ./$(DST) && zip ./$(BIN)_binary_$(GOARCH)_windows.zip ./$(BIN).exe
	mv ./$(DST)/$(BIN).exe ./$(DST)/$(BIN)_windows.exe
release-for-mac:
	mv ./$(DST)/$(BIN)_macOS ./$(DST)/$(BIN)
	cd ./$(DST) && zip ./$(BIN)_binary_$(GOARCH)_macOS.zip ./$(BIN)
	mv ./$(DST)/$(BIN) ./$(DST)/$(BIN)_macOS
release-for-linux:
	mv ./$(DST)/$(BIN)_linux ./$(DST)/$(BIN)
	cd ./$(DST) && zip ./$(BIN)_binary_$(GOARCH)_linux.zip ./$(BIN)
	mv ./$(DST)/$(BIN) ./$(DST)/$(BIN)_linux

release-clean:
	cd ./$(DST)
	rm ./$(DST)/$(BIN)_windows.exe
	rm ./$(DST)/$(BIN)_macOS
	rm ./$(DST)/$(BIN)_linux

