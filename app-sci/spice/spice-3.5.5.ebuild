# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/spice/spice-3.5.5.ebuild,v 1.4 2003/02/13 09:26:09 vapier Exp $

MY_P="spice3f5sfix"
DESCRIPTION="SPICE 3 is a general-purpose circuit simulation program"
HOMEPAGE="http://bwrc.eecs.berkeley.edu/Classes/IcBook/SPICE/"
SRC_URI="http://www.ibiblio.org/pub/Linux/apps/circuits/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	sys-libs/ncurses"
S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A} ; cd ${S}/conf
	sed -e "s:termcap:ncurses:g" linux > linux.1
	sed -e "s:joe:emacs:g" linux.1 > linux.2
	sed -e "s:-O2 -s:${CFLAGS}:g" linux.2 > linux.3
	sed -e "s:SPICE_DIR)/lib:SPICE_DIR)/lib/spice:g" linux.3 > linux.4
	sed -e "s:/usr/local/spice:/usr:g" linux.4 > linux
}

src_compile() {
	./util/build linux
	obj/bin/makeidx lib/helpdir/spice.txt
}

src_install() {
	# install binaries
	install -d ${D}/usr/bin
	install -s obj/bin/spice3 ${D}/usr/bin
	dosym /usr/bin/spice3 /usr/bin/spice
	install -s obj/bin/help ${D}/usr/bin/spice.help
	install -s obj/bin/nutmeg ${D}/usr/bin
	install -s obj/bin/sconvert ${D}/usr/bin
	install -s obj/bin/multidec ${D}/usr/bin
	install -s obj/bin/proc2mod ${D}/usr/bin
	# install runtime stuff
	rm -f lib/make*
	dodir /usr/lib/spice
	cp -R lib/* ${D}/usr/lib/spice/
	# install docs
	doman man/man1/*
	dodoc doc readme readme.Linux notes/spice2
}
