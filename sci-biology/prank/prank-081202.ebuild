# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/prank/prank-081202.ebuild,v 1.3 2009/08/10 08:00:34 ssuominen Exp $

EAPI=2
inherit eutils

DESCRIPTION="Probabilistic Alignment Kit"
HOMEPAGE="http://www.ebi.ac.uk/goldman-srv/prank/prank/"
SRC_URI="http://www.ebi.ac.uk/goldman-srv/prank/src/prank.src.${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

S=${WORKDIR}/src

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch
	perl -i -pe 's/(CC|CXX|CFLAGS|CXXFLAGS)\s*=/#/' "${S}/Makefile" || die
}

src_install() {
	dobin prank || die "dobin failed"
}
