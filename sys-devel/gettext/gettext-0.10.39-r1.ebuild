# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gettext/gettext-0.10.39-r1.ebuild,v 1.1 2001/08/28 00:34:35 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU locale utilities"
SRC_URI="ftp://gatekeeper.dec.com/pub/GNU/gettext/${P}.tar.gz ftp://prep.ai.mit.edu/gnu/gettext/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/gettext/gettext.html"

if [ -z "`use build`" ] ; then
DEPEND="virtual/glibc"
fi

src_unpack() {
	unpack ${A}
	cd ${S}/misc
	cp Makefile.in Makefile.in.orig
	#This fix stops gettext from invoking emacs to install the po mode
	sed -e '185,187d' Makefile.in.orig > Makefile.in
	#Eventually, installation of the po mode should be performed in pkg_postinst()
}

src_compile() {
    local myconf
    if [  -z "`use nls`" ]
    then
        myconf="--disable-nls"
    fi 
    ./configure --prefix=/usr --infodir=/usr/share/info --mandir=/usr/share/man --with-included-gettext --disable-shared --host=${CHOST} ${myconf} || die
    emake || die
}

src_install() {
	make prefix=${D}/usr infodir=${D}/usr/share/info mandir=${D}/usr/share/man lispdir=${D}/usr/share/emacs/site-lisp install || die
	dodoc AUTHORS BUGS COPYING ChangeLog DISCLAIM NEWS README* THANKS TODO
	
	#glibc includes gettext; this isn't needed anymore
	rm -rf ${D}/usr/lib/*

	#again, installed by glibc
	rm -rf ${D}/usr/share/locale/locale.alias
	
	if [ -d ${D}/usr/doc/gettext ]
	then
		mv ${D}/usr/doc/gettext ${D}/usr/share/doc/${PF}/html
		rm -rf ${D}/usr/doc
   	fi
	exeopts -m0755
	exeinto /usr/bin
	doexe misc/gettextize
}


