# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/streamripper/streamripper-1.60.10.ebuild,v 1.2 2004/10/20 05:41:37 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="Extracts and records individual MP3 file tracks from shoutcast streams"
HOMEPAGE="http://streamripper.sourceforge.net/"
SRC_URI="http://streamripper.sourceforge.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND="media-libs/libmad"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.8"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/streamripper-1.60.8-syslibmad.patch

	# Force package to use system libmad
	rm -rf libmad-0.15.1b

	WANT_AUTOMAKE=1.8 aclocal >& /dev/null
	WANT_AUTOMAKE=1.8 automake
	WANT_AUTOCONF=2.5 autoconf
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc TODO README THANKS readme_xfade.txt
}
