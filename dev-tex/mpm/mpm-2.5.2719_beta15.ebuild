# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/mpm/mpm-2.5.2719_beta15.ebuild,v 1.1 2007/07/10 10:45:13 opfer Exp $

inherit eutils

MY_PV=${PV/_beta/-beta-}
DESCRIPTION="MiKTeX Tools -- package manager for a TeX distribution"
HOMEPAGE="http://www.miktex.org/unx/"
SRC_URI="mirror://sourceforge/miktex/miktex-tools-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-misc/curl
		dev-libs/pth
		virtual/tetex"

S="${WORKDIR}/miktex-tools-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-2.5.2398_beta14-multipleroots.patch"
}
src_install() {
	make DESTDIR="${D}" install || die "install failed"
}

pkg_postinst() {
	elog ""
	elog "Remember to run \"mpm --update-db\" as root before using mpm."
	elog ""
}
