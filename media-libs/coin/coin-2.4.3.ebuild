# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/coin/coin-2.4.3.ebuild,v 1.1 2005/07/12 14:17:20 smithj Exp $

MY_P=${P/c/C}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An OpenSource implementation of SGI's OpenInventor"
HOMEPAGE="http://www.coin3d.org/"
SRC_URI="ftp://ftp.coin3d.org/pub/coin/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE="X"

DEPEND="virtual/x11
	virtual/opengl"

src_compile() {
	econf $(use_with X x) || die
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
