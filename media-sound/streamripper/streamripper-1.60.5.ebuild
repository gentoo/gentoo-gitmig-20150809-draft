# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/streamripper/streamripper-1.60.5.ebuild,v 1.4 2004/07/19 20:10:34 eradicator Exp $

inherit eutils

DESCRIPTION="Extracts and records individual MP3 file tracks from shoutcast streams"
HOMEPAGE="http://streamripper.sourceforge.net/"
SRC_URI="http://streamripper.sourceforge.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc amd64"
IUSE=""

RDEPEND="media-libs/libmad"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.8"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-interface.patch
	epatch ${FILESDIR}/${P}-syslibmad.patch

	# Force package to use system libmad
	rm -rf libmad-0.15.1b

	WANT_AUTOMAKE=1.8 aclocal >& /dev/null
	WANT_AUTOMAKE=1.8 automake
	WANT_AUTOCONF=2.5 autoconf
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc TODO README THANKS readme_xfade.txt
}
