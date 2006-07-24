# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tarsync/tarsync-0.2-r1.ebuild,v 1.1 2006/07/24 03:22:54 zmedico Exp $

inherit eutils

DESCRIPTION="Delta compression suite for using/generating binary patches"
HOMEPAGE="http://dev.gentoo.org/~ferringb/"
SRC_URI="http://dev.gentoo.org/~ferringb/${PN}/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~hppa ~ppc ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${PV}"

DEPEND=">=dev-util/diffball-0.7"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/bug_140593_strcmp.patch"
}

src_compile() {
	cd "${S}"
	emake || die "emake failed"
}

src_install() {
	cd ${S}
	make DESTDIR="${D}" install || die "failed installing"
}
