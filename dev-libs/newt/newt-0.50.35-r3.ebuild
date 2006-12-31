# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/newt/newt-0.50.35-r3.ebuild,v 1.6 2006/12/31 17:05:34 xmerlin Exp $

inherit python

DESCRIPTION="redhat's newt windowing toolkit development files"
SRC_URI="http://koto.mynetix.de/gentoo/${P}.tar.gz"
HOMEPAGE="http://www.redhat.com"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~hppa ~amd64 ~alpha"
IUSE=""

DEPEND="=sys-libs/slang-1*
	>=dev-libs/popt-1.6
	dev-lang/python"

RDEPEND=""

src_compile() {
	python_version
	export RPM_OPT_FLAGS="${CFLAGS}"
	econf || die
	make PYTHONVERS=python${PYVER} || die "make failure"
}

src_install () {
	make prefix=${D}/usr PYTHONVERS=python${PYVER} install || die "make install failed"
	dodoc CHANGES COPYING peanuts.py popcorn.py tutorial.sgml
	dosym libnewt.so.${PV} /usr/lib/libnewt.so.0.50
}
