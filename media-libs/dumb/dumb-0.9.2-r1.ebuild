# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/dumb/dumb-0.9.2-r1.ebuild,v 1.1 2003/07/20 04:45:20 jje Exp $

DESCRIPTION="IT/XM/S3M/MOD player library with click removal and IT filters. Most users will also want the 'aldumb' package."
SRC_URI="mirror://sourceforge/dumb/${P}-fixed.tar.gz"
HOMEPAGE="http://dumb.sourceforge.net/"

LICENSE="DUMB-0.9.2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND=""

S=${WORKDIR}/${PN}

src_compile() {
	echo 'include make/unix.inc' > make/config.txt || die
	echo 'ALL_TARGETS := core core-examples core-headers' >> make/config.txt || die
	echo 'PREFIX := /usr' >> make/config.txt || die
	emake OFLAGS="${CFLAGS}" all || die
}

src_install() {
	dodir /usr/lib /usr/include /usr/bin
	make install PREFIX=${D}/usr || die

	dodoc readme.txt release.txt docs/*

	einfo
	einfo "DUMB's core has been installed. This will enable you to convert module"
	einfo "files to PCM data (ready for sending to /dev/dsp, writing to a .wav"
	einfo "file, piping through oggenc, etc.)."
	einfo
	einfo "If you are using Allegro, you will also want to 'emerge aldumb'. This"
	einfo "provides you with a convenient API for playing module files through"
	einfo "Allegro's sound system, and also enables DUMB to integrate with"
	einfo "Allegro's datafile system so you can add modules to datafiles."
	einfo
	einfo "As a developer, when you distribute your game and write your docs, be"
	einfo "aware that 'dumb' and 'aldumb' actually come from the same download."
	einfo "People who don't use Gentoo will only have to download and install one"
	einfo "package. See /usr/share/doc/${PF}/readme.txt.gz for details on"
	einfo "how DUMB would be compiled manually."
	einfo
}

