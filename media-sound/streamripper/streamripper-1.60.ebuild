# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/streamripper/streamripper-1.60.ebuild,v 1.4 2005/03/26 00:28:12 hansmi Exp $

inherit eutils

MY_P="${P/_/.}"
DESCRIPTION="Extracts and records individual MP3 file tracks from shoutcast streams"
HOMEPAGE="http://streamripper.sourceforge.net/"
SRC_URI="http://streamripper.sourceforge.net/files/${MY_P}.tar.gz
	mirror://gentoo/${P}-interface.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE=""

DEPEND="media-libs/libmad"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	epatch ${P}-interface.patch

	# Force package to use system libmad
	cd ${S}
	sed -i 's:libmad::' configure
	rm libmad/*
	echo 'all:' > libmad/Makefile
}

src_compile() {
	econf || die
	emake MADLIBOBJS=/usr/lib/libmad.so || die
}

src_install() {
	dobin streamripper || die
	doman streamripper.1
	dodoc CHANGES README THANKS TODO readme_xfade.txt
}
