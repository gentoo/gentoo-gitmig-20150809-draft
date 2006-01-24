# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcms/wmcms-0.3.5-r1.ebuild,v 1.7 2006/01/24 22:46:40 nelchael Exp $

inherit eutils

IUSE=""

DESCRIPTION="WindowMaker CPU and Memory Usage Monitor Dock App."
SRC_URI="http://orbita.starmedia.com/~neofpo/files/${P}.tar.bz2"
HOMEPAGE="http://orbita.starmedia.com/~neofpo/wmcms.html"

DEPEND="x11-libs/libdockapp"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64 ppc ppc64"

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
