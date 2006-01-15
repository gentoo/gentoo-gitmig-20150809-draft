# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmnetload/wmnetload-1.3-r2.ebuild,v 1.4 2006/01/15 17:56:34 nelchael Exp $

inherit eutils

IUSE=""

DESCRIPTION="Network interface monitor dockapp"
HOMEPAGE="http://freshmeat.net/projects/wmnetload/"
SRC_URI="ftp://truffula.com/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc ppc64 sparc"

DEPEND="x11-libs/libdockapp"

src_unpack()
{
	unpack ${A}
	cd ${S}

	# Add support for libdockapp 0.5
	epatch ${FILESDIR}/add_support_for_libdockapp_0.5.patch

	epatch ${FILESDIR}/wmnetload-1.3-norpath.patch
}

src_compile()
{
	econf || die "configure failed"
	emake || die "parallel make failed"
}

src_install()
{
	einstall || die "make install failed"
	dodoc AUTHORS README NEWS
}
