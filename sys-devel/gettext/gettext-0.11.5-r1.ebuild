# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gettext/gettext-0.11.5-r1.ebuild,v 1.8 2003/05/20 02:26:57 kumba Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU locale utilities"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gettext/gettext.html"
IUSE="nls"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa arm ~mips"

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
	rm -rf ${D}/usr/include
	rm -rf ${D}/usr/lib/*.{a,so}

	#again, installed by glibc
	rm -rf ${D}/usr/share/locale/locale.alias

	if [ -d ${D}/usr/doc/gettext ]
	then
		mv ${D}/usr/doc/gettext ${D}/usr/share/doc/${PF}/html
		rm -rf ${D}/usr/doc
   	fi

	dodoc AUTHORS BUGS COPYING ChangeLog DISCLAIM NEWS README* THANKS TODO
}

