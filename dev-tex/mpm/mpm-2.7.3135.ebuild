# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/mpm/mpm-2.7.3135.ebuild,v 1.1 2009/07/16 18:46:36 fauli Exp $

inherit eutils cmake-utils

DESCRIPTION="MiKTeX Tools -- package manager for a TeX distribution"
HOMEPAGE="http://www.miktex.org/unx/"
SRC_URI="http://www.ctan.org/pub/tex-archive/systems/win32/miktex/source/miktex-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="test"

DEPEND="net-misc/curl
		dev-libs/pth
		virtual/latex-base
		www-client/lynx
		dev-libs/libxslt
		!media-sound/mpc"
RDEPEND="${DEPEND}"

S="${WORKDIR}/miktex-${PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-2.7.2817-multipleroots.patch"
}

pkg_postinst() {
	elog ""
	elog "Remember to run \"mpm --update-db\" as root before using mpm."
	elog ""
}
