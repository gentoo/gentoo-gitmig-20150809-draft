# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/gzip/gzip-1.3.3-r2.ebuild,v 1.6 2004/03/28 08:17:57 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Standard GNU compressor"
HOMEPAGE="http://www.gnu.org/software/gzip/gzip.html"
SRC_URI="http://www.gzip.org/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa mips ia64 ppc64 s390 amd64"
IUSE="nls build static"

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"
PROVIDE="virtual/gzip"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-security.patch
}

src_compile() {
	# Compiling with gcc3 and higher level of optimization seems to
	# cause a segmentation fault in some very rare cases on alpha.
	[ ${ARCH} = "alpha" ] && CFLAGS="-O -pipe"

	use static && append-flags -static

	econf \
		--exec-prefix=/ \
		`use_enable nls` \
		|| die
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

	if ! use build
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
