NEOTERM_PREFIX := /data/data/io.neoterm/files/usr
NEOTERM_BASE_DIR := /data/data/io.neoterm/files
CFLAGS += -Wall -Wextra -Werror -Oz

libneoterm-exec.so: neoterm-exec.c
	$(CC) $(CFLAGS) $(LDFLAGS) neoterm-exec.c -DNEOTERM_PREFIX=\"$(NEOTERM_PREFIX)\" -DNEOTERM_BASE_DIR=\"$(NEOTERM_BASE_DIR)\" -shared -fPIC -o libneoterm-exec.so

install: libneoterm-exec.so
	install libneoterm-exec.so $(DESTDIR)$(PREFIX)/lib/libneoterm-exec.so

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/lib/libneoterm-exec.so

test: libneoterm-exec.so
	@LD_PRELOAD=${CURDIR}/libneoterm-exec.so ./run-tests.sh

clean:
	rm -f libneoterm-exec.so tests/*-actual

.PHONY: clean install test uninstall
