# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mp/mp-3.2.10.ebuild,v 1.1 2004/01/14 00:20:44 mholzer Exp $

S=${WORKDIR}/${P}
DESCRIPTION="mp, the definitive text editor"
SRC_URI="http://www.triptico.com/download/${P}.tar.gz"
HOMEPAGE="http://www.triptico.com/software/mp.html"

DEPEND="virtual/glibc
	ncurses? ( sys-libs/ncurses )
	gtk? ( =x11-libs/gtk+-1.2* )"

RDEPEND="${DEPEND}
	dev-lang/perl"
IUSE="ncurses gtk"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

src_compile() {
	if [ -n "`use ncurses`" ] && [ -n "`use gtk`" ]; then emake || die;
	elif [ -n "`use ncurses`" ]; then emake mp || die;
	elif [ -n "`use gtk`" ]; then emake gmp || die;
	else die "You need ncurses and/or gtk in your USE variables";
	fi
}

src_install () {
	dodir /usr/bin
	make install PREFIX=${D}/usr || die "install failed"
	dodoc AUTHORS Changelog COPYING README
	dohtml README.html doc/mp_api.html

	insinto /usr/share/pixmaps/
	doins mp.xpm
}
