# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/coin/coin-2.1.0.ebuild,v 1.3 2004/02/05 01:45:01 vapier Exp $

MY_P=${P/c/C}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An OpenSource implementation of SGI's OpenInventor"
HOMEPAGE="http://www.coin3d.org/"
SRC_URI="ftp://ftp.coin3d.org/pub/coin/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="virtual/x11
	virtual/opengl"

src_compile() {
	econf `use_with X x` || die
	emake || die
}

src_install() {
	# Note that this is slightly different from einstall
	make DESTDIR=${D} \
		prefix=/usr \
		datadir=/usr/share \
		infodir=/usr/share/info \
		localstatedir=/var/lib \
		mandir=/usr/share/man \
		sysconfdir=/etc \
		install || die "make install failed"

	dodoc AUTHORS BUGS.txt COPYING ChangeLog HACKING LICENSE* NEWS README* RELEASE RELNOTES THANKS
	docinto txt
	dodoc docs/*.txt
}
