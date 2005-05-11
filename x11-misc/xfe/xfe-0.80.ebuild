# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfe/xfe-0.80.ebuild,v 1.1 2005/05/11 08:28:00 s4t4n Exp $

DESCRIPTION="MS-Explorer like file manager for X"
HOMEPAGE="http://roland65.free.fr/xfe/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc ~ppc64"
IUSE="nls"

# only fox-1.4.x is compatible with this version of xfe...
DEPEND="=x11-libs/fox-1.4*"

src_compile()
{
	econf `use_enable nls` || die
	emake || die
}

src_install()
{
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS FAQ README TODO NEWS
}

pkg_postinst()
{
	einfo
	einfo 	"Please delete your old Xfe registry files"
	einfo 	" (~/.foxrc/Xfe ~/.foxrc/Xfv and ~/.foxrc/Xfq)"
	einfo	"before using this XFE 0.80 release"
	einfo
}
