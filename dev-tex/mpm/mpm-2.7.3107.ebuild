# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/mpm/mpm-2.7.3107.ebuild,v 1.2 2008/07/12 09:09:29 opfer Exp $

inherit eutils cmake-utils

DESCRIPTION="MiKTeX Tools -- package manager for a TeX distribution"
HOMEPAGE="http://www.miktex.org/unx/"
SRC_URI="http://ftp.dante.de/tex-archive/systems/win32/miktex/source/miktex-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-misc/curl
		dev-libs/pth
		virtual/latex-base
		www-client/lynx
		!media-sound/mpc"

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
