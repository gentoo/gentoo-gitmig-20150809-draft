# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcms/wmcms-0.3.5-r1.ebuild,v 1.1 2004/07/20 20:56:18 s4t4n Exp $

inherit eutils

IUSE=""

DESCRIPTION="WindowMaker CPU and Memory Usage Monitor Dock App."
SRC_URI="http://orbita.starmedia.com/~neofpo/files/${P}.tar.bz2"
HOMEPAGE="http://orbita.starmedia.com/~neofpo/wmcms.html"

DEPEND="virtual/x11
	>=x11-libs/libdockapp-0.4.0-r1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"

src_unpack()
{
	unpack ${A}
	epatch ${FILESDIR}/wmcms-0.3.5-s4t4n.patch
}

src_compile()
{
	emake CFLAGS="${CFLAGS}" || die "Compilation failed."
}

src_install ()
{
	dobin wmcms
}
