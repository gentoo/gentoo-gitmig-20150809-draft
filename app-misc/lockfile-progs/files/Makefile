all: lockfile-create
.PHONY: all

install: all
	install -d $(DESTDIR)/usr/bin

	install --mode=755 lockfile-create $(DESTDIR)/usr/bin/lockfile-create
	ln -s lockfile-create $(DESTDIR)/usr/bin/lockfile-remove
	ln -s lockfile-create $(DESTDIR)/usr/bin/lockfile-touch
	ln -s lockfile-create $(DESTDIR)/usr/bin/lockfile-check

	install --mode=755 lockfile-create $(DESTDIR)/usr/bin/mail-lock
	ln -s mail-lock $(DESTDIR)/usr/bin/mail-unlock
	ln -s mail-unlock $(DESTDIR)/usr/bin/mail-touchlock

	install -d $(DESTDIR)/usr/share/man/man1

	install --mode=644 lockfile-progs.1 $(DESTDIR)/usr/share/man/man1
	ln -s lockfile-progs.1 $(DESTDIR)/usr/share/man/man1/lockfile-create.1
	ln -s lockfile-progs.1 $(DESTDIR)/usr/share/man/man1/lockfile-remove.1
	ln -s lockfile-progs.1 $(DESTDIR)/usr/share/man/man1/lockfile-touch.1
	ln -s lockfile-progs.1 $(DESTDIR)/usr/share/man/man1/lockfile-check.1

	ln -s lockfile-progs.1 $(DESTDIR)/usr/share/man/man1/mail-lock.1
	ln -s lockfile-progs.1 $(DESTDIR)/usr/share/man/man1/mail-unlock.1
	ln -s lockfile-progs.1 $(DESTDIR)/usr/share/man/man1/mail-touchlock.1
.PHONY: install

lockfile-create: lockfile-progs.o
	${CC} -o $@ ${CFLAGS} ${LDFLAGS} $^ -llockfile
