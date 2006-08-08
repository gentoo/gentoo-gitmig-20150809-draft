# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/mpm/mpm-2.5.2398_beta14.ebuild,v 1.1 2006/08/08 21:19:15 nattfodd Exp $

MY_PV=${PV/_beta/-beta-}
DESCRIPTION="MiKTeX Tools -- package manager for a TeX distribution"
HOMEPAGE="http://www.miktex.org/unx/"
SRC_URI="mirror://sourceforge/miktex/miktex-tools-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-misc/curl
		dev-libs/pth
		virtual/tetex"

S="${WORKDIR}/miktex-tools-${MY_PV}"

src_install() {
	make DESTDIR=${D} install || die "install failed"
}

pkg_postinst() {
	einfo ""
	einfo "Remember to run \"mpm --update-db\" as root before using mpm."
	einfo ""
}
