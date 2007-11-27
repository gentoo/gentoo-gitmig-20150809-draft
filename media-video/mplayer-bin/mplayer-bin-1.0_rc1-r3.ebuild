# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer-bin/mplayer-bin-1.0_rc1-r3.ebuild,v 1.4 2007/11/27 12:03:37 zzam Exp $

inherit multilib eutils

DESCRIPTION="Pre-build mplayer binary for amd64 systems"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${PF}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

RDEPEND=">=app-emulation/emul-linux-x86-baselibs-10.1
	>=app-emulation/emul-linux-x86-soundlibs-10.0
	>=app-emulation/emul-linux-x86-gtklibs-10.0
	>=app-emulation/emul-linux-x86-sdl-10.0
	>=app-emulation/emul-linux-x86-medialibs-10.1
	>=media-libs/win32codecs-20061022-r1"
S="${WORKDIR}"
RESTRICT="strip"

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Daniel Gryniewicz <dang@gentoo.org>
	has_multilib_profile || die
	ABI="x86"

	if ! built_with_use app-emulation/emul-linux-x86-xlibs opengl; then
		eerror "Please rebuild emul-linux-x86-xlibs with the opengl USE flag"
		die "emul-linux-x86-xlibs needs support for opengl"
	fi
}

src_install() {
	cp -pPRvf "${WORKDIR}"/* "${D}"/
	dosym /opt/mplayer-bin/bin/mplayer-bin /opt/mplayer-bin/bin/gmplayer-bin
	dosed dosed -e "s/gmplayer/gmplayer-bin/" /opt/mplayer-bin/share/applications/mplayer.desktop
	dosym /opt/mplayer-bin/share/applications/mplayer.desktop /usr/share/applications/mplayer-bin.desktop
	dodir /opt/mplayer-bin/lib
	dosym /usr/$(get_libdir)/win32 /opt/mplayer-bin/lib/win32
}
