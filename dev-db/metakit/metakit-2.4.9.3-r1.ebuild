# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/metakit/metakit-2.4.9.3-r1.ebuild,v 1.1 2004/02/13 21:48:41 kloeri Exp $

inherit python

DESCRIPTION="Embedded database library"
HOMEPAGE="http://www.equi4.com/metakit/"
SRC_URI="http://www.equi4.com/pub/mk/${P}.tar.gz"

LICENSE="MetaKit"
SLOT="0"
KEYWORDS="~x86"
IUSE="python tcltk"

DEPEND=">=sys-apps/sed-4
	python? ( >=dev-lang/python-2.2.1 )
	tcltk? ( >=dev-lang/tcl-8.3.3-r2 )"

src_unpack() {
	unpack ${A} ; cd ${S}
	sed -i "s:^\(CXXFLAGS = \).*:\1${CXXFLAGS}:" unix/Makefile.in
	sed -i "s:python2.3/site-packages:python-2.3/site-packages:" unix/configure.in
}

src_compile() {
	local myconf
	use python && myconf="--with-python"
	use tcltk && myconf="${myconf} --with-tcl=/usr/include"

	CXXFLAGS="${CXXFLAGS}" unix/configure \
		${myconf} \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	emake || die
}

src_install () {
	python_version

	[ `use python` ] && dodir /usr/lib/python-${PYVER}/site-packages
	make DESTDIR=${D} install || die

	dodoc CHANGES README WHATSNEW
	dohtml MetaKit.html
	dohtml -a html,gif,png,jpg -r doc/*
}
