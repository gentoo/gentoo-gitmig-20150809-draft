# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfe/xfe-0.70-r1.ebuild,v 1.1 2004/09/04 00:04:42 s4t4n Exp $

inherit eutils

DESCRIPTION="MS-Explorer like file manager for X"
HOMEPAGE="http://roland65.free.fr/xfe/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE="nls"

# fox-1.0.x, fox-1.1.x and fox-1.3.x are inkompatible.
DEPEND="=x11-libs/fox-1.2*"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# Fix #62428
	epatch ${FILESDIR}/xfe-0.70-file-association.patch
}

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
	einfo	"before using this XFE 0.70 release"
	einfo
}
