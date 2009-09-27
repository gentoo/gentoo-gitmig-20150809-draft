# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libconfig/libconfig-1.3.2.ebuild,v 1.4 2009/09/27 19:42:22 nixnut Exp $

EAPI="2"

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

src_prepare() {
	sed -i -e 's#^SUBDIRS = . samples doc$#SUBDIRS = . doc#' Makefile.am

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
