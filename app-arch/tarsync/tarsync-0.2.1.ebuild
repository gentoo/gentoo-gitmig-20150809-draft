# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tarsync/tarsync-0.2.1.ebuild,v 1.2 2006/08/07 20:58:43 ticho Exp $

DESCRIPTION="Delta compression suite for using/generating binary patches"
HOMEPAGE="http://gentooexperimental.org/~ferringb/tarsync/"
SRC_URI="http://gentooexperimental.org/~ferringb/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~hppa ~ppc x86"
IUSE=""

S="${WORKDIR}/${PN}"

DEPEND=">=dev-util/diffball-0.7"
RDEPEND="${DEPEND}"

src_compile() {
	cd "${S}"
	emake || die "emake failed"
}

src_install() {
	cd ${S}
	make DESTDIR="${D}" install || die "failed installing"
}
