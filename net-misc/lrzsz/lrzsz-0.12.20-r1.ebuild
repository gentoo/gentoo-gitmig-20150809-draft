# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/lrzsz/lrzsz-0.12.20-r1.ebuild,v 1.8 2003/09/05 22:01:49 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="communication package providing the X, Y, and ZMODEM file transfer protocols"
SRC_URI="http://www.ohse.de/uwe/releases/${P}.tar.gz"
HOMEPAGE="http://www.ohse.de/uwe/software/lrzsz.html"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"
SLOT="0"

DEPEND=""

#RDEPEND=""

src_compile() {
	local options

	use nls || options="${options} --disable-nls"

	export CFLAGS="${CFLAGS} -Wstrict-prototypes"

	./configure	\
		--infodir=/usr/share/info 	\
		--mandir=/usr/share/man		\
		--prefix=/usr	\
		--host=${CHOST}	\
		${options} || die

	emake || die
}

src_install () {
	make 	\
		prefix=${D}/usr	\
		mandir=${D}/usr/share/man	\
		install || die

	dosym /usr/bin/lrb /usr/bin/rb
	dosym /usr/bin/lrx /usr/bin/rx
	dosym /usr/bin/lrz /usr/bin/rz
	dosym /usr/bin/lsb /usr/bin/sb
	dosym /usr/bin/lsx /usr/bin/sx
	dosym /usr/bin/lsz /usr/bin/sz

	dodoc ABOUT-NLS AUTHORS COMPATABILITY COPYING ChangeLog NEWS
	dodoc README* THANKS TODO
}

