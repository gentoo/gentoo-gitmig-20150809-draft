# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libconfig/libconfig-1.2.ebuild,v 1.5 2008/03/31 21:22:27 maekke Exp $

inherit autotools

DESCRIPTION="Libconfig is a simple library for manipulating structured configuration files"
HOMEPAGE="http://www.hyperrealm.com/libconfig/libconfig.html"
SRC_URI="http://www.hyperrealm.com/libconfig/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 ~sparc x86"
IUSE=""

DEPEND="sys-devel/libtool"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i -e 's#^SUBDIRS = . samples doc$#SUBDIRS = . doc#' Makefile.am

	eautoreconf || die
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
}
