# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnetload/wmnetload-1.3-r1.ebuild,v 1.5 2004/10/19 08:59:35 absinthe Exp $

inherit eutils

IUSE=""

DESCRIPTION="Network interface monitor dockapp"
HOMEPAGE="http://freshmeat.net/projects/wmnetload/"
SRC_URI="ftp://truffula.com/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc ppc64"

DEPEND="virtual/x11
	>=x11-libs/libdockapp-0.5.0"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# Add support for libdockapp 0.5
	epatch ${FILESDIR}/add_support_for_libdockapp_0.5.patch
}

src_compile()
{
	econf || die "configure failed"
	emake || die "parallel make failed"
}

src_install()
{
	einstall || die "make install failed"
	dodoc AUTHORS README NEWS INSTALL COPYING
}
