# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/metakit/metakit-2.4.9.2-r1.ebuild,v 1.4 2004/01/29 21:09:41 kloeri Exp $

DESCRIPTION="Embedded database library"
HOMEPAGE="http://www.equi4.com/metakit/"
SRC_URI="http://www.equi4.com/pub/mk/${P}.tar.gz"

LICENSE="MetaKit"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE="python tcltk"

DEPEND=">=sys-apps/sed-4
	python? ( >=dev-lang/python-2.2.1 )
	tcltk? ( >=dev-lang/tcl-8.3.3-r2 )"

src_unpack() {
	unpack ${A} ; cd ${S}
	sed -i "s:^\(CXXFLAGS = \).*:\1${CXXFLAGS}:" unix/Makefile.in
	PY_VER="$(python -c 'import sys; print sys.version[0:3]')"
	if [ ${PY_VER} == '2.3' ]; then
		sed -i "s:/python2.2:/python${PY_VER}:" unix/configure
		sed -i 's:LONG_LONG :PY_LONG_LONG :' python/scxx/PWONumber.h
		sed -i 's:\(LONG_LONG\):\(PY_LONG_LONG\):' python/PyRowRef.cpp
	fi
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
	local pydir
	pydir=`python-config | cut -d" " -f1 | sed -e 's/-l//g'`/site-packages

	[ `use python` ] && dodir /usr/lib/${pydir}
	make DESTDIR=${D} install || die

	dodoc CHANGES README WHATSNEW
	dohtml MetaKit.html
	dohtml -a html,gif,png,jpg -r doc/*
}
