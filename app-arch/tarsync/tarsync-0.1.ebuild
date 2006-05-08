# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/tarsync/tarsync-0.1.ebuild,v 1.6 2006/05/08 05:11:25 tcort Exp $


DESCRIPTION="Delta compression suite for using/generating binary patches"
HOMEPAGE="http://dev.gentoo.org/~ferringb/"
SRC_URI="http://dev.gentoo.org/~ferringb/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~hppa ppc x86"
IUSE=""

S="${WORKDIR}/${PN}"

DEPEND=">=sys-libs/zlib-1.1.4
	>=app-arch/bzip2-1.0.2"

src_compile() {
	emake tarsync || die "emake failed"
}

src_install() {
	cd ${S}
	einstall || die
}
