# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/winki/winki-0.3.2.ebuild,v 1.1 2004/10/23 01:43:10 chriswhite Exp $

inherit distutils

DESCRIPTION="A Python frontend to many popular encoding programs."
HOMEPAGE="http://www.informatik.hu-berlin.de/~hristov/projects/winki/index.html"
SRC_URI="http://www.informatik.hu-berlin.de/~hristov/projects/winki/dist/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="vcd css"
DEPEND=">=dev-lang/python-2.3
		>=dev-python/gnome-python-2
		>=dev-python/pygtk-2
		>=dev-python/pyorbit-2
		vcd? ( media-libs/libdvb )
		css? ( media-libs/libdvdcss )"
RDEPEND="${DEPEND}
		media-video/mplayer
		media-video/lsdvd
		media-sound/ogmtools
		media-sound/vorbis-tools
		vcd? ( media-video/vcdimager )"

src_unpack() {
	unpack ${A}

	cd ${S}

	#fixes some sandbox violations
	#and the sudden odd urge for upstream
	#to want data files in /opt :|
	epatch ${FILESDIR}/${P}.patch

	#remove their "hard coding" of /opt/winki
	cd ${S}/winki
	for bad_code in *
	do
		if [ -f $bad_code ] ; then
			sed -e "s:/opt/winki:/usr/share/winki:" -i $bad_code || die "/opt to /usr/share patching failed!"
		fi
	done
}
