# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/spice/spice-3.5.5.ebuild,v 1.5 2003/03/01 03:43:38 vapier Exp $

MY_P="spice3f5sfix"
DESCRIPTION="general-purpose circuit simulation program"
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
	cp linux{,.orig}
	sed -e "s:termcap:ncurses:g" \
		-e "s:joe:emacs:g" \
		-e "s:-O2 -s:${CFLAGS}:g" \
		-e "s:SPICE_DIR)/lib:SPICE_DIR)/lib/spice:g" \
		-e "s:/usr/local/spice:/usr:g" \
		linux.orig > linux
}

src_compile() {
	./util/build linux || die
	obj/bin/makeidx lib/helpdir/spice.txt || die
}

src_install() {
	# install binaries
	dobin obj/bin/{spice3,nutmeg,sconvert,multidec,proc2mod}
	newbin obj/bin/help spice.help
	dosym /usr/bin/spice3 /usr/bin/spice
	# install runtime stuff
	rm -f lib/make*
	dodir /usr/lib/spice
	cp -R lib/* ${D}/usr/lib/spice/
	# install docs
	doman man/man1/*.1
	dodoc doc readme readme.Linux notes/spice2
}
