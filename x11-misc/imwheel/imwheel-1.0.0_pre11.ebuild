# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/imwheel/imwheel-1.0.0_pre11.ebuild,v 1.2 2004/06/19 12:08:23 pyrania Exp $

inherit eutils

DESCRIPTION="mouse tool for advanced features such as wheels and 3+ buttons"
HOMEPAGE="http://imwheel.sourceforge.net/"
SRC_URI="mirror://sourceforge/imwheel/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""
DEPEND="virtual/x11"
S="${WORKDIR}/${P/_/}"

src_unpack() {
	unpack ${A}
	cd ${S}
	#epatch ${FILESDIR}/${P}-gentoo.diff
	sed -i -e "s:/etc:${D}/etc:g" Makefile.am || die
	sed -i -e "s:/etc:${D}/etc:g" Makefile.in || die
}

src_compile() {
	local myconf

	# don't build gpm stuff
	myconf="--disable-gpm --disable-gpm-doc"

	econf ${myconf} || die "configure failed"
	emake || die "parallel make failed"
}

src_install() {
	einstall || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog EMACS M-BA47 NEWS README TODO
}
