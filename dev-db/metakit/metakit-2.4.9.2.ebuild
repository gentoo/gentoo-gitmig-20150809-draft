# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/metakit/metakit-2.4.9.2.ebuild,v 1.2 2003/06/11 11:44:33 seemant Exp $

IUSE="python tcltk"

S=${WORKDIR}/${P}
DESCRIPTION="Embedded database library"
HOMEPAGE="http://www.equi4.com/metakit/"
SRC_URI="http://www.equi4.com/pub/mk/${P}.tar.gz"

DEPEND=">=sys-apps/sed-4
	python? ( >=dev-lang/python-2.2.1 )
	tcltk? ( >=dev-lang/tcl-8.3.3-r2 )"

SLOT="0"
LICENSE="MetaKit"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A} ; cd ${S}
	sed -i "s:^\(CXXFLAGS = \).*:\1${CXXFLAGS}:" unix/Makefile.in
}

src_compile() {
	local myconf
	use python && myconf="--enable-python"
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

	make DESTDIR=${D} install || die

	if [ -n "`use python`" ]
	then
		dodir /usr/lib/${pydir}
		# Because libmk4py.so export Mk4pyinit, that Python will look for ...
		# shouldn't do a mv instead of a cp ? Who needs libmk4py.so ?
		cp ${D}/usr/lib/libmk4py.so ${D}/usr/lib/${pydir}/Mk4py.so
		cp python/metakit.py ${D}/usr/lib/${pydir}
	fi

	dodoc CHANGES README WHATSNEW
	dohtml MetaKit.html
	dohtml -a html,gif,png,jpg -r doc/*
}
