# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/taglib/taglib-1.0_beta2.ebuild,v 1.9 2004/02/08 19:30:54 lu_zero Exp $

inherit flag-o-matic

MY_PV=0.96
DESCRIPTION="A library for reading and editing audio meta data"
HOMEPAGE="http://ktown.kde.org/~wheeler/taglib/"
SRC_URI="http://ktown.kde.org/~wheeler/taglib/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~amd64 ~ppc"

DEPEND=">=sys-devel/autoconf-2.58"
RDEPEND=""

S=${WORKDIR}/${PN}-${MY_PV}

src_compile() {
	replace-flags "-O3 -O2"
	rm -rf autom4te.cache
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7
	aclocal && autoconf && automake
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} destdir=${D} || die
}
