# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author William McArthur <leknor@leknor.com>
# $HEADER $

S=${WORKDIR}/${P}
DESCRIPTION="Hard drive bottleneck testing benchmark suite."
SRC_URI="http://www.coker.com.au/bonnie++/${P}.tgz"
HOMEPAGE="http://www.coker.com.au/bonnie++/"

DEPEND="virtual/glibc"

src_compile() {
	if [ "$DEBUG" == "true" ]
	then
		myconf="--with-debug --disable-stripping"
	fi

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		$myconf || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	# make install doesn't respect DESTDIR or anything else.
	#make DESTDIR=${D} install || die "make install failed"
	# make install-bin will respect eprefix but would still need clean up
	#make eprefix=${D} install-bin || die "make install-bin failed"

	# Explicit
	dobin bonnie++ zcav
	dobin bon_csv2html bon_csv2txt
	doman bon_csv2html.1 bon_csv2txt.1 bonnie++.8 zcav.8
	dohtml readme.html
	dodoc changelog.txt copyright.txt credits.txt
}
