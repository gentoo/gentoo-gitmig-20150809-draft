# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ipodder/ipodder-2.0_rc4.ebuild,v 1.1 2005/07/09 09:27:28 chriswhite Exp $

inherit eutils

MY_PV="${PV/_/-}"
MY_PN="${PN/ipodder/iPodder-linux}"
MY_P="${MY_PN}-${MY_PV}"
S="${WORKDIR}/${MY_PN}"

DESCRIPTION="A cross-platform Podcast receiver"
HOMEPAGE="http://ipodder.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
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
	epatch ${FILESDIR}/${PV}-wx26-selector.patch
}

src_install() {
	insinto /opt/iPodder
	doins -r *

	# Fix perms
	fperms 644 /opt/iPodder/ipodder/players.py

	newbin ${S}/ipodder.sh ipodder
	insinto /usr/share/pixmaps
	doins ${S}/iPodder.png

	make_desktop_entry "ipodder" "iPodder" \
		"iPodder.png" "AudioVideo;Player"
}
