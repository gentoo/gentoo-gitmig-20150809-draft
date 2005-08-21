# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/streamripper/streamripper-1.61.11.ebuild,v 1.1 2005/08/21 16:45:57 chainsaw Exp $

inherit eutils

DESCRIPTION="Extracts and records individual MP3 file tracks from shoutcast streams"
HOMEPAGE="http://streamripper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="media-libs/libmad"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Force package to use system libmad
	rm -rf libmad*
	sed -i -e 's/libmad//' Makefile.in || die

	# for some reason the install-sh file is not executable on OSX...
	chmod a+x install-sh
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README THANKS readme_xfade.txt
}
