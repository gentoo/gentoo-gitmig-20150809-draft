# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/nas/nas-1.4.2.ebuild,v 1.2 2002/07/11 06:30:39 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Network Audio System"

SRC_URI="http://radscan.com/nas/nas-1.4.2.src.tar.gz"

HOMEPAGE="http://radscan.com/nas.html"

# This is ridculuous, we only need xmkmf, but no other package
# provides it.
DEPEND=">=x11-base/xfree-4"

src_compile() {

	xmkmf
	touch doc/man/lib/tmp.{_man,man}
	emake World || die
}

src_install () {
	make DESTDIR=${D} install || die
	make DESTDIR=${D} install.man || die
	
	for i in ${D}/usr/X11R6/man/man?/*.?x 
	do
		gzip -9 $i
	done
	
	dodoc BUGS BUILDNOTES FAQ HISTORY README RELEASE TODO
	mv ${D}/usr/X11R6/lib/X11/doc/html ${D}/usr/share/doc/${P}/
	rmdir ${D}/usr/X11R6/lib/X11/doc
	
	
}

