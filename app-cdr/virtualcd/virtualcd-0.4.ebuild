# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/virtualcd/virtualcd-0.4.ebuild,v 1.1 2003/04/29 22:43:58 vapier Exp $

DESCRIPTION="mount bin/cue cd images"
HOMEPAGE="http://outertech.com/robert/virtualcd/"
SRC_URI="http://outertech.com/robert/virtualcd/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/kernel"

S=${WORKDIR}/${P/-/_}

src_compile() {
	${CC} virtualcd.c -o virtualcd.o -c \
		${CFLAGS} -D__KERNEL__ -DMODULE -Wall \
		-I/usr/src/linux/include \
		|| die "could not make kernel module"

	cd vcsetup
	econf || die
	emake || die
}

src_install() {
	insinto /lib/modules/`uname -r`/kernel/fs/virtualcd/
	doins virtualcd.o

	cd vcsetup
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog README TODO
}
