# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/metakit/metakit-2.4.7.37.ebuild,v 1.10 2004/01/25 08:08:33 vapier Exp $

S=${WORKDIR}/${PN}-${PV%.*}
DESCRIPTION="Embedded database library"
HOMEPAGE="http://www.equi4.com/metakit/"
SRC_URI="http://www.equi4.com/pub/mk/${PN}-${PV%.*}-${PV##*.}.tar.gz"

LICENSE="MetaKit"
SLOT="0"
KEYWORDS="x86 ppc hppa"
IUSE="python tcltk"

DEPEND="python? ( >=dev-lang/python-2.2.1 )
	tcltk? ( >=dev-lang/tcl-8.3.3-r2 )"

src_unpack() {
	unpack ${A} ; cd ${S}
	cp unix/Makefile.in unix/Makefile.in.orig
	sed -e "s:^\(CXXFLAGS = \).*:\1${CXXFLAGS}:" unix/Makefile.in.orig \
		> unix/Makefile.in
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

	einstall

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
