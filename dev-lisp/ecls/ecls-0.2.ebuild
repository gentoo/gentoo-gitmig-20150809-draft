# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/ecls/ecls-0.2.ebuild,v 1.13 2004/07/14 16:22:08 agriffis Exp $

DESCRIPTION="Embeddable Common Lisp 'Spain'"
SRC_URI="mirror://sourceforge/ecls/${P}.tgz"
HOMEPAGE="http://ecls.sourceforge.net/"

SLOT="0"
LICENSE="BSD LGPL-2"
KEYWORDS="x86"
IUSE="X"

PROVIDE="virtual/commonlisp"

src_compile() {

	local myconf

	if use X
	then
		myconf="${myconf} --with-x"
	else
		myconf="${myconf} --with-x=no"
	fi

	echo ${CXXFLAGS} ${CFLAGS} ${LSPCFLAGS}
	./configure --prefix=/usr ${myconf}  || die

	#
	# FIXME: This really needs to be triple-verified
	#
	local mcpu=`echo ${CFLAGS} | sed "s/.*-mcpu=\([a-zA-Z0-9]*\).*/\1/g"`
	local march=`echo ${CFLAGS} | sed "s/.*-march=\([a-zA-Z0-9]*\).*/\1/g"`

	echo ${mcpu} -- ${march}

	for i in build/{crs,c,gc,tk,.}/Makefile ; do
	   cp $i $i.orig ;
	   cat $i.orig | sed -e "s:-mcpu= 1:-mcpu=${mcpu}:g" | sed -e "s:-march= 1:-march=${march}:g" > $i ;
	done

	cp build/gabriel/Makefile build/gabriel/Makefile.orig
	cat build/gabriel/Makefile.orig | sed "s/FILES =.*/FILES = ECLSc ECLSi/g" > build/gabriel/Makefile

	touch LGPL

	alias lisp='echo NOT INSTALLED!'
	echo ${CXXFLAGS} ${CFLAGS}
	make || die

}

src_install() {
	make install PREFIX=${D}/usr || die
}
