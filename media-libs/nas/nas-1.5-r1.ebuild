# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/nas/nas-1.5-r1.ebuild,v 1.3 2004/11/17 06:00:08 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="Network Audio System"
HOMEPAGE="http://radscan.com/nas.html"
SRC_URI="http://radscan.com/nas/${P}.src.tar.gz"

SLOT="0"
LICENSE="X11"
KEYWORDS="alpha hppa ~ppc sparc x86"

# This is ridculuous, we only need xmkmf, but no other package
# provides it. 20020607 (Seemant): Actually, the homepage says it needs
# the entire X11 build environment, so this is ok.
DEPEND="virtual/x11"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-libaudioMakefile.patch
}

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
