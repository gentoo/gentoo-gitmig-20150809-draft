# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/streamripper/streamripper-1.60.5.ebuild,v 1.1 2004/06/15 07:26:16 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="Extracts and records individual MP3 file tracks from shoutcast streams"
HOMEPAGE="http://streamripper.sourceforge.net/"
SRC_URI="http://streamripper.sourceforge.net/files/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"

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
	dodoc COPYING TODO README THANKS readme_xfade.txt
}
