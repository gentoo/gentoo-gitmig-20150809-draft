# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/guile-cairo/guile-cairo-1.4.0.ebuild,v 1.1 2007/09/09 17:41:06 hkbst Exp $

inherit eutils

DESCRIPTION="Wraps the Cairo graphics library for Guile Scheme"
HOMEPAGE="home.gna.org/guile-cairo/"
SRC_URI="http://download.gna.org/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND=">=dev-scheme/guile-1.8
	>=x11-libs/cairo-1.4"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
#	epatch "${FILESDIR}"/${PV}-various-fixes-20070601.patch
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "install failed"

	dodoc ChangeLog || die "dodoc failed"
}
