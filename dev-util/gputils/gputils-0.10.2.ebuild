# Copyright 1999-2002 Gentoo Technologies, Inc. 
# Distributed under the terms of the GNU General Public License, v2 or later 
# Author: Jeffry Molanus  <gila@home.nl>
# Maintainer: Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/gputils/gputils-0.10.2.ebuild,v 1.1 2002/04/24 20:20:08 karltk Exp $

S=${WORKDIR}/${P} 
DESCRIPTION="Utils for the PICxxx procesors" 
SRC_URI="http://prdownloads.sourceforge.net/gputils/${P}.tar.gz" 
HOMEPAGE="http://gputils.sourceforge.net/" 
 
src_compile(){ 
 
         ./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--sysconfdir=/etc || die 
	emake
} 
 
src_install() { 
	make prefix=${D}/usr/share \
		bindir=${D}/usr/bin \
		confdir=${D}/etc \
		datadir=${D}/usr/share/ \
		mandir=${D}/usr/share/man \
		install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	dodoc doc/gputils.ps
}
