# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/castpodder/castpodder-3.2.ebuild,v 1.1.1.1 2005/11/30 09:38:11 chriswhite Exp $

inherit eutils

MY_PV="${PV/_/-}"
MY_PN="${PN/castpodder/CastPodder}"
MY_P="${MY_PN}-${MY_PV}"
S="${WORKDIR}/${PN}"

DESCRIPTION="A cross-platform Podcast receiver, based on iPodder"
HOMEPAGE="http://www.castpodder.net/"
SRC_URI="http://borgforge.net/frs/download.php/14/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-lang/python-2.3.0
		>=dev-python/wxpython-2.6
		>=dev-python/pyxmms-2.02
		>=sys-libs/db-4.2.52_p2"

useflag_test() {
	built_with_use ${1} ${2} || die \
"${1} must be emerged with the '${2}' USE flag enabled."
}

pkg_setup() {
	useflag_test x11-libs/wxGTK unicode
	useflag_test dev-python/wxpython unicode
	useflag_test dev-lang/python berkdb
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}"/${P}-wxversion.patch
}

src_install() {
	insinto /opt/CastPodder
	# Doesn't work with doins -r * (this is done as in install.sh)
	cp -R ${S}/* ${D}/opt/CastPodder/

	# Fix perms
	#fperms 644 /opt/CastPodder/ipodder/players.py

	newbin ${S}/CastPodder.sh castpodder
	insinto /usr/share/pixmaps
	doins ${S}/CastPodder.png

	make_desktop_entry "castpodder" "CastPodder" \
		"CastPodder.png" "AudioVideo;Player"
}
