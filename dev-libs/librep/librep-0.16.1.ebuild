# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# # $Header: /var/cvsroot/gentoo-x86/dev-libs/librep/librep-0.16.1.ebuild,v 1.10 2003/09/06 22:29:24 msterret Exp $

IUSE="readline"

inherit libtool

S=${WORKDIR}/${P}

DESCRIPTION="Shared library implementing a Lisp dialect"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://librep.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc  ppc alpha"

DEPEND=">=sys-libs/gdbm-1.8.0
	sys-apps/texinfo
	>=sys-devel/automake-1.6.1-r5"

src_compile() {

	elibtoolize

	local myconf=""

	myconf="--without-readline --without-gmp"

	LC_ALL=""
	LINGUAS=""
	LANG=""
	export LC_ALL LINGUAS LANG

	econf \
		--libexecdir=/usr/lib \
		${myconf} || die "configure failure"

	make -j1 host_type=${CHOST} || die "compile failure"
}

src_install() {
	make install \
		host_type=${CHOST} \
		DESTDIR=${D} \
		aclocaldir=/usr/share/aclocal \
		infodir=/usr/share/info || die

	insinto /usr/include
	doins src/rep_config.h

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README THANKS TODO DOC TREE
	docinto doc
	dodoc doc/*
}
