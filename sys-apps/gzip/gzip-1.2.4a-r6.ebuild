# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gzip/gzip-1.2.4a-r6.ebuild,v 1.14 2003/06/21 21:19:39 drobbins Exp $

IUSE="nls build"

S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU compressor"
SRC_URI="ftp://prep.ai.mit.edu/gnu/gzip/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gzip/gzip.html"
KEYWORDS="x86 amd64 sparc "
SLOT="0"
DEPEND="virtual/glibc nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	[ -z "`use nls`" ] && myconf="--disable-nls"
	./configure --host=${CHOST} --prefix=/usr --exec-prefix=/ --mandir=/usr/share/man --infodir=/usr/share/info ${myconf} || die
	emake || die
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	make prefix=${D}/usr exec_prefix=${D}/ mandir=${D}/usr/share/man/man1 infodir=${D}/usr/share/info install || die
	cd ${D}/bin
	for i in gzexe zforce zgrep zmore znew zcmp
	do
	  cp ${i} ${i}.orig
	  sed -e "1d" -e "s:${D}::" ${i}.orig > ${i}
	  rm ${i}.orig
	  chmod 755 ${i}
	done
	if [ -z "`use build`" ]
	then
		cd ${D}/usr/share/man/man1
		for i in gzexe gzip zcat zcmp zdiff zforce  zgrep zmore znew
		do
			rm ${i}.1
			ln -s gunzip.1.gz ${i}.1.gz
		done
		cd ${S}
		rm -rf ${D}/usr/man ${D}/usr/lib
		dodoc ChangeLog COPYING NEWS README THANKS TODO
		docinto txt
		dodoc algorithm.doc gzip.doc
	else
		rm -rf ${D}/usr
	fi
}
