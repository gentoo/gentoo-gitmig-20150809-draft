# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vsound/vsound-0.5.ebuild,v 1.7 2004/04/01 08:43:35 eradicator Exp $

DESCRIPTION="Sort a virtual audio loopback cable for RealAudio to wave convertions."
HOMEPAGE="http://www.zip.com.au/~erikd/vsound/"
LICENSE="GPL-2"
DEPEND=">=media-sound/sox-12.17.1"

KEYWORDS="x86"
SLOT="0"
SRC_URI="mirror://debian/pool/main/v/vsound/${P/-/_}.orig.tar.gz
	mirror:///debian/pool/main/v/vsound/${P/-/_}-3.diff.gz"
RESTRICT="nomirror"

src_unpack() {
	cd ${WORKDIR}
	unpack ${P/-/_}.orig.tar.gz
	cd ${S}
	gunzip --stdout ${DISTDIR}/${P/-/_}-3.diff.gz | patch -p1 || die
}

src_compile() {
	./configure --prefix=/usr		\
		    --infodir=/usr/share/info	\
		    --mandir=/usr/share/man	\
		    --host=${CHOST} || die

	emake || die
}


src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING Changelog INSTALL NEWS README README.original
}
