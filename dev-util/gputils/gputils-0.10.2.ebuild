# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gputils/gputils-0.10.2.ebuild,v 1.8 2003/02/13 11:55:31 vapier Exp $

S=${WORKDIR}/${P} 
DESCRIPTION="Utils for the PICxxx procesors" 
SRC_URI="mirror://sourceforge/gputils/${P}.tar.gz" 
HOMEPAGE="http://gputils.sourceforge.net/" 
 
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc"

src_compile(){ 
 
 	econf || die
	emake || die
} 
 
src_install() { 
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
	dodoc doc/gputils.ps
}
