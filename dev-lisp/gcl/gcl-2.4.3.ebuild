# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gcl/gcl-2.4.3.ebuild,v 1.10 2004/07/14 16:22:33 agriffis Exp $

DESCRIPTION="GNU Common Lisp"
SRC_URI="ftp://ftp.gnu.org/gnu/gcl/gcl-2.4.3.tgz"
HOMEPAGE="http://www.gnu.org/software/gcl/gcl.html"
PROVIDE="virtual/commonlisp"

DEPEND=">=app-text/texi2html-1.64
	>=dev-libs/gmp-4.1"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

src_compile() {

	cd ${S} ;  echo `pwd`
	./configure --prefix=/usr || die

	for i in */makefile makedefs makedefc makefile config.status ; do
		mv $i $i.orig ;
		cat $i.orig | \
			sed -e 's|./configure: emacs: command not found|${prefix}/share/emacs/site-lisp/gcl|g' > $i
	done

	for i in  makedefs makedefc ; do
		mv $i $i.libs.orig ;
		cat $i.libs.orig | \
			sed -e 's|/usr/lib/gcc-lib/i686-pc-linux-gnu/3.2/../../../libbfd.a /usr/lib/gcc-lib/i686-pc-linux-gnu/3.2/libiberty.a|-liberty -lbfd|g' > $i
	done

	cd ${S}
	make ${MAKEOPTS} || die

}

src_install() {

	dodir /usr/share/info
	dodir /usr/share/emacs/site-lisp/gcl

	make install prefix=${D}/usr MANDIR=${D}/usr/share/man \
		INFO_DIR=${D}/usr/share/info EMACS_SITE_LISP=${D}/usr/share/emacs/site-lisp/gcl \
		EMACS_DEFAULT_EL=${D}/usr/share/emacs/site-lisp/gcl/default.el \
		|| die

	rm -f ${D}/usr/share/infodir

	mv ${D}/usr/lib/${P}/info/* ${D}/usr/share/info
	rm ${D}/usr/share/info/texinfo.tex
	rm ${D}/usr/share/emacs/site-lisp/gcl/default.el

	mv ${D}/usr/bin/gcl ${D}/usr/bin/gcl.orig
	sed -e "s:${D}::g" < ${D}/usr/bin/gcl.orig > ${D}/usr/bin/gcl
	rm ${D}/usr/bin/gcl.orig

	# fix the GCL_TK_DIR=/var/tmp/portage/gcl-2.4.3/image//
	mv ${D}/usr/lib/gcl-2.5.0/gcl-tk/gcltksrv ${D}/usr/lib/gcl-2.5.0/gcl-tk/gcltksrv.orig
	sed -e "s:${D}::g" < ${D}/usr/lib/gcl-2.5.0/gcl-tk/gcltksrv.orig > ${D}/usr/lib/gcl-2.5.0/gcl-tk/gcltksrv
	rm ${D}/usr/lib/gcl-2.5.0/gcl-tk/gcltksrv.orig
	chmod 0755 ${D}/usr/lib/gcl-2.5.0/gcl-tk/gcltksrv

	chmod 0755 ${D}/usr/bin/gcl

	#repair gcl.exe symlink
	rm ${D}/usr/bin/gcl.exe
	dosym ../lib/gcl-2.5.0/unixport/saved_gcl /usr/bin/gcl.exe
}
