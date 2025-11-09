# dwm - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

TOPBUILDDIR ?= ..
BIN_DIR = $(TOPBUILDDIR)/bin

SRC = drw.c dwm.c util.c
OBJ = $(SRC:.c=.o)
OBJ := $(addprefix $(BIN_DIR)/, $(notdir $(OBJ)))

all: $(BIN_DIR)/dwm

# Compile object files into bin/
$(BIN_DIR)/%.o: %.c
	mkdir -p $(BIN_DIR)
	$(CC) -c $(CFLAGS) $< -o $@

$(OBJ): config.h config.mk

config.h:
	cp config.def.h $@

$(BIN_DIR)/dwm: $(OBJ)
	$(CC) -o $@ $(OBJ) $(LDFLAGS)

clean:
	rm -f $(BIN_DIR)/dwm $(OBJ) dwm-$(VERSION).tar.gz

dist: clean
	mkdir -p dwm-$(VERSION)
	cp -R LICENSE Makefile README config.def.h config.mk\
		dwm.1 drw.h util.h $(SRC) dwm.png transient.c dwm-$(VERSION)
	tar -cf dwm-$(VERSION}.tar dwm-$(VERSION)
	gzip dwm-$(VERSION}.tar
	rm -rf dwm-$(VERSION)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f $(BIN_DIR)/dwm $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dwm
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < dwm.1 > $(DESTDIR)$(MANPREFIX)/man1/dwm.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/dwm.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dwm\
		$(DESTDIR)$(MANPREFIX)/man1/dwm.1

.PHONY: all clean dist install uninstall
