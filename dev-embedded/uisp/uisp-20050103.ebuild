# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/uisp/uisp-20050103.ebuild,v 1.2 2005/03/21 03:21:48 vapier Exp $

inherit eutils

DESCRIPTION="tool for AVR microcontrollers which can interface to many hardware in-system programmers"
HOMEPAGE="http://savannah.nongnu.org/projects/uisp"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
#SRC_URI="http://savannah.nongnu.org/download/uisp/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
S=${WORKDIR}/${PN}

DEPEND="sys-apps/gawk
	sys-devel/gcc
	>=sys-devel/automake-1.7
	>=sys-devel/autoconf-2.57"
RDEPEND=""

#src_unpack() {
#	unpack ${A}
#	cd ${S}/src
#	epatch ${FILESDIR}/uisp-gcc34.patch
#}

src_compile() {
	rm -rf autom4te.cache
	export WANT_AUTOCONF=2.57 WANT_AUTOMAKE=1.7
	aclocal || die "aclocal failed"
	autoheader || die "autoheader failed"
	autoconf || die "autoconf failed"
	automake --foreign --add-missing --copy || die "automake failed"
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"
	dodoc doc/*
	prepalldocs
}
