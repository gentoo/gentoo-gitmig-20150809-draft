# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/gcl/gcl-2.5.2.ebuild,v 1.2 2003/05/16 06:30:42 george Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="GNU Common Lisp"
SRC_URI="ftp://ftp.gnu.org/gnu/gcl/gcl-${PV}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gcl/gcl.html"
PROVIDE="virtual/commonlisp"

DEPEND=">=app-text/texi2html-1.64
	>=dev-libs/gmp-4.1
	>=app-text/tetex-2.0*"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

src_compile() {

	cd ${S} ;  echo `pwd`
	./configure --disable-statsysbfd --enable-locbfd --prefix=/usr || die

	cd ${S}
	make || die

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
	rmdir ${D}/usr/lib/${P}/info/
	rm ${D}/usr/share/emacs/site-lisp/gcl/default.el

	mv ${D}/usr/bin/gcl ${D}/usr/bin/gcl.orig
	sed -e "s:${D}::g" < ${D}/usr/bin/gcl.orig > ${D}/usr/bin/gcl
	rm ${D}/usr/bin/gcl.orig

	# fix the GCL_TK_DIR=/var/tmp/portage/gcl-2.4.3/image//
	mv ${D}/usr/lib/${P}/gcl-tk/gcltksrv ${D}/usr/lib/${P}/gcl-tk/gcltksrv.orig
	sed -e "s:${D}::g" < ${D}/usr/lib/${P}/gcl-tk/gcltksrv.orig > ${D}/usr/lib/${P}/gcl-tk/gcltksrv
	rm ${D}/usr/lib/${P}/gcl-tk/gcltksrv.orig
	chmod 0755 ${D}/usr/lib/${P}/gcl-tk/gcltksrv

	chmod 0755 ${D}/usr/bin/gcl

	#repair gcl.exe symlink
	rm ${D}/usr/bin/gcl.exe
	dosym ../lib/${P}/unixport/saved_gcl /usr/bin/gcl.exe

	#move docs to proper place
	cd ${S}
	dodoc readme* RELEASE* doc/*
	mv ${D}/usr/share/info../doc/gcl-doc/* ${D}/usr/share/doc/${PF}
	rm -rf ${D}/usr/share/info../
}
