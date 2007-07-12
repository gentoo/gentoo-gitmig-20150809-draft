# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libvc/libvc-003-r1.ebuild,v 1.2 2007/07/12 02:25:34 mr_bones_ Exp $

inherit eutils

DESCRIPTION="vCard library (rolo)"
HOMEPAGE="http://rolo.sourceforge.net/"
SRC_URI="mirror://sourceforge/rolo/${P}.tar.bz2"
RESTRICT="mirror"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-count_vcards.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS INSTALL NEWS README THANKS ChangeLog
}
