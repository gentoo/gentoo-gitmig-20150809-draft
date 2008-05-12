# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/qe/qe-0.2.0.ebuild,v 1.2 2008/05/12 06:48:19 drac Exp $

inherit autotools eutils

PATCH_LEVEL=4

DESCRIPTION="PE2-like editor program under U*nix with Chinese support"
HOMEPAGE="http://www.geocities.com/linux4tw/qe"
SRC_URI="http://www.geocities.com/linux4tw/qe/${P}.tar.gz
	mirror://debian/pool/main/q/qe/${P/-/_}-${PATCH_LEVEL}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${P/-/_}-${PATCH_LEVEL}.diff
	sed -i -e '/AC_REQUIRE/d' -e 's/-O2//g' \
		configure.in || die "sed failed."
	eautoreconf
}

src_install() {
	emake pkgdatadir="${D}/usr/share/qe" DESTDIR="${D}" \
		install || die "emake install failed."
	dodoc AUTHORS ChangeLog README*
	newdoc debian/changelog ChangeLog.debian
}
