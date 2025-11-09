SUBDIRS := dwm dmenu

.PHONY: all clean install uninstall

all:
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir; \
	done

clean:
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir clean; \
	done

install:
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir install; \
	done

uninstall:
	@for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir uninstall; \
	done
