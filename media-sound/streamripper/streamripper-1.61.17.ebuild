# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/streamripper/streamripper-1.61.17.ebuild,v 1.1 2006/01/24 20:26:36 chutzpah Exp $

DESCRIPTION="Extracts and records individual MP3 file tracks from shoutcast streams"
HOMEPAGE="http://streamripper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="media-libs/libmad
	media-libs/libogg
	media-libs/libvorbis"

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
