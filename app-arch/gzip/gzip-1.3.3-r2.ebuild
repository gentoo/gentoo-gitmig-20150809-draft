# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/gzip/gzip-1.3.3-r2.ebuild,v 1.3 2003/12/17 03:55:48 brad_mssw Exp $

IUSE="nls build"

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="Standard GNU compressor"
HOMEPAGE="http://www.gnu.org/software/gzip/gzip.html"
SRC_URI="http://www.gzip.org/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha hppa arm mips ia64 ppc64"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"

PROVIDE="virtual/gzip"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-security.patch
}

src_compile() {
	[ -z "`use nls`" ] && myconf="--disable-nls"

	# Compiling with gcc3 and higher level of optimization seems to
	# cause a segmentation fault in some very rare cases on alpha.
	[ ${ARCH} = "alpha" ] && CFLAGS="-O -pipe"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--exec-prefix=/ \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		${myconf} || die
	emake || die
}

src_install() {
	dodir /usr/bin /usr/share/man/man1
	make prefix=${D}/usr \
		exec_prefix=${D}/ \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	cd ${D}/bin
	for i in gzexe zforce zgrep zmore znew zcmp
	do
		dosed -e "1d" -e "s:${D}::" ${i}
		chmod 755 ${i}
	done

	# No need to waste space -- these guys should be links
	# gzcat is equivilant to zcat, but historically zcat
	# was a link to compress.
	rm -f gunzip zcat zcmp zegrep zfgrep
	dosym gzip /bin/gunzip
	dosym gzip /bin/gzcat
	dosym gzip /bin/zcat
	dosym zdiff /bin/zcmp
	dosym zgrep /bin/zegrep
	dosym zgrep /bin/zfgrep

	if [ -z "`use build`" ]
	then
		cd ${D}/usr/share/man/man1
		rm -f gunzip.* zcmp.* zcat.*
		ln -s gzip.1.gz gunzip.1.gz
		ln -s zdiff.1.gz zcmp.1.gz
		ln -s gzip.1.gz zcat.1.gz
		ln -s gzip.1.gz gzcat.1.gz
		cd ${S}
		rm -rf ${D}/usr/man ${D}/usr/lib
		dodoc ChangeLog COPYING NEWS README THANKS TODO
		docinto txt
		dodoc algorithm.doc gzip.doc
	else
		rm -rf ${D}/usr
	fi
}

