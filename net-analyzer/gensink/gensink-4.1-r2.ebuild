# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/gensink/gensink-4.1-r2.ebuild,v 1.1 2012/11/10 12:00:57 pinkbyte Exp $

EAPI="4"

inherit base toolchain-funcs

DESCRIPTION="A simple TCP benchmark suite"
HOMEPAGE="http://jes.home.cern.ch/jes/gensink/"
SRC_URI="http://jes.home.cern.ch/jes/gensink/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

PATCHES=( "${FILESDIR}/${P}-make.patch" )

src_compile() {
	tc-export CC
	emake
}
src_install() {
	dobin sink4 tub4 gen4
}
