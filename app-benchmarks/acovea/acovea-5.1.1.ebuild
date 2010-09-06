# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/acovea/acovea-5.1.1.ebuild,v 1.9 2010/09/06 23:22:02 ssuominen Exp $

EAPI=2

WANT_AUTOMAKE=1.9

inherit autotools eutils

DESCRIPTION="Analysis of Compiler Options via Evolutionary Algorithm"
HOMEPAGE="http://www.coyotegulch.com/products/acovea/"
SRC_URI="http://www.coyotegulch.com/distfiles/lib${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=dev-libs/libcoyotl-3.1.0
	>=dev-libs/libevocosm-3.1.0
	dev-libs/expat"
DEPEND="${RDEPEND}"

S=${WORKDIR}/lib${P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch \
		"${FILESDIR}"/${P}-free-fix.patch \
		"${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-glibc-212.patch
	if has_version ">=dev-libs/libevocosm-3.3.0"; then
		epatch ${FILESDIR}"/${P}-libevocosm.patch"
	fi
	eautomake
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README
}
