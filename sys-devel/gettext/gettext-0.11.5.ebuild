# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gettext/gettext-0.11.5.ebuild,v 1.13 2004/07/15 03:28:34 agriffis Exp $

DESCRIPTION="GNU locale utilities"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/gettext/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gettext/gettext.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86 ppc sparc alpha hppa mips"
IUSE="nls"

src_unpack() {
	unpack ${A}

	cd ${S}/misc
	cp Makefile.in Makefile.in.orig
	#This fix stops gettext from invoking emacs to install the po mode
	sed -e '185,187d' Makefile.in.orig > Makefile.in || die
	#Eventually, installation of the po mode should be performed in pkg_postinst()
}

src_compile() {
	local myconf=""
	use nls || myconf="--disable-nls"

	econf \
		--with-included-gettext \
		--disable-shared \
		${myconf} || die

	emake || die
}

src_install() {
	einstall \
		lispdir=${D}/usr/share/emacs/site-lisp \
		docdir=${D}/usr/share/doc/${PF}/html \
		|| die

	exeopts -m0755
	exeinto /usr/bin
	doexe misc/gettextize

	#glibc includes gettext; this isn't needed anymore
	rm -rf ${D}/usr/{include,lib}/*

	#again, installed by glibc
	rm -rf ${D}/usr/share/locale/locale.alias

	if [ -d ${D}/usr/doc/gettext ]
	then
		mv ${D}/usr/doc/gettext ${D}/usr/share/doc/${PF}/html
		rm -rf ${D}/usr/doc
	fi

	dodoc AUTHORS BUGS COPYING ChangeLog DISCLAIM NEWS README* THANKS TODO
}
