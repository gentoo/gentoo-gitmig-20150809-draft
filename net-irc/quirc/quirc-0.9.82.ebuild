# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dmitriy Kropivnitskiy <nigde@mitechki.net> aka Jeld The Dark Elf
# $Header: /var/cvsroot/gentoo-x86/net-irc/quirc/quirc-0.9.82.ebuild,v 1.1 2002/04/25 20:40:20 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GUI IRC client scriptable in Tcl/Tk"
SRC_URI="http://quirc.org/${P}.tar.gz"
HOMEPAGE="http://quirc.org/"

DEPEND="dev-lang/tcl 
	dev-lang/tk"


src_compile() {

	./configure \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--datadir=/usr/share/quirc \
		|| die "./configure failed"

	emake || die
}

src_install () {

	make \
		DESTDIR=${D} \
		distdir=${D}/usr/share/quirc \
		pkgdatadir=${D}/usr/share \
		install || die

	# this package's install script is a little screwy so we need to move things
	# around a bit in the ${D} directory
	dodir /usr/share/quirc
	mv ${D}${D}usr/share/* ${D}/usr/share/quirc

	insinto /usr/share/quirc/common
	doins ${S}/data/common/*

	insinto /usr/share/quirc/themes
	doins ${S}/data/themes/*

	# this package installs docs, but we would rather do that ourselves
	dodoc README NEWS INSTALL FAQ ChangeLog* COPYING AUTHORS
	dodoc doc/*
	
	#clean up from package's messy install
	rm -rf ${D}${D}
	rm -rf ${D}/usr/doc
	rm -rf ${D}usr/share/common 
	rm -rf ${D}usr/share/themes
}
