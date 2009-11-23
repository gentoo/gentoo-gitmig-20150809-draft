# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/liborigin/liborigin-20080225-r1.ebuild,v 1.2 2009/11/23 01:57:11 bicatali Exp $

EAPI=2
inherit eutils

DESCRIPTION="A library for reading OriginLab OPJ project files"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/liborigin/"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

SLOT="0"
IUSE=""

DEPEND="dev-cpp/tree"
RDEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-makefile.patch
	rm tree.hh || die
}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README FORMAT || die "dodoc failed"
}
