# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/dumb/dumb-0.9.3-r1.ebuild,v 1.9 2007/04/30 22:57:35 genone Exp $

IUSE="debug"

inherit eutils

DESCRIPTION="IT/XM/S3M/MOD player library with click removal and IT filters"
HOMEPAGE="http://dumb.sourceforge.net/"
SRC_URI="mirror://sourceforge/dumb/${P}.tar.gz"

KEYWORDS="alpha amd64 ia64 ppc sparc x86"
LICENSE="DUMB-0.9.2"
SLOT="0"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	cat << EOF > make/config.txt
include make/unix.inc
ALL_TARGETS := core core-examples core-headers
PREFIX := /usr
EOF

	epatch "${FILESDIR}"/${PN}-0.9.2-PIC.patch
	epatch "${FILESDIR}"/${P}_CVE-2006-3668.patch
	sed -i '/= -s/d' Makefile || die "sed failed"
	cp Makefile Makefile.rdy
}

src_compile() {
	emake OFLAGS="${CFLAGS}" all || die "emake failed"
}

src_install() {
	dobin examples/{dumbout,dumb2wav}
	dolib.so lib/unix/libdumb.so

	use debug && dolib.so lib/unix/libdumbd.so

	insinto /usr/include
	doins include/dumb.h

	dodoc readme.txt release.txt docs/* || die "dodoc failed"
}

pkg_postinst() {
	elog
	elog "DUMB's core has been installed. This will enable you to convert module"
	elog "files to PCM data (ready for sending to /dev/dsp, writing to a .wav"
	elog "file, piping through oggenc, etc.)."
	elog
	elog "If you are using Allegro, you will also want to 'emerge aldumb'. This"
	elog "provides you with a convenient API for playing module files through"
	elog "Allegro's sound system, and also enables DUMB to integrate with"
	elog "Allegro's datafile system so you can add modules to datafiles."
	elog
	elog "As a developer, when you distribute your game and write your docs, be"
	elog "aware that 'dumb' and 'aldumb' actually come from the same download."
	elog "People who don't use Gentoo will only have to download and install one"
	elog "package. See /usr/share/doc/${PF}/readme.txt.gz for details on"
	elog "how DUMB would be compiled manually."
	elog
}
