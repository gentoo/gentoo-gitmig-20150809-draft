# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/wfmath/wfmath-0.3.5.ebuild,v 1.1 2007/02/01 07:59:53 tupone Exp $

DESCRIPTION="Worldforge math library."
HOMEPAGE="http://www.worldforge.org/dev/eng/libraries/wfmath"
SRC_URI="mirror://sourceforge/worldforge/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND=""
DEPEND="doc? ( app-doc/doxygen )
	media-libs/atlas-c++"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	if use doc; then
		cd doc && emake doc || die "making doc failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || "installing docs failed"
	if use doc; then
		dohtml doc/html/*  || "installing html failed"
	fi
}
