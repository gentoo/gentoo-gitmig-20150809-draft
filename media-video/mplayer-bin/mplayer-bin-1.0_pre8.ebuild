# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayer-bin/mplayer-bin-1.0_pre8.ebuild,v 1.4 2007/07/02 15:23:16 peper Exp $

inherit multilib

DESCRIPTION="Pre-build mplayer binary for amd64 systems"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${PF}.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="lirc"

RDEPEND=">=app-emulation/emul-linux-x86-baselibs-2.0
	>=app-emulation/emul-linux-x86-soundlibs-2.2
	>=app-emulation/emul-linux-x86-gtklibs-2.8
	>=app-emulation/emul-linux-x86-sdl-2.1
	>=app-emulation/emul-linux-x86-medialibs-1.2
	>=media-libs/win32codecs-20050412
	lirc? ( app-misc/lirc )"

DEPEND=""

S=${WORKDIR}

RESTRICT="strip"

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Daniel Gryniewicz <dang@gentoo.org>
	has_multilib_profile || die
	ABI="x86"
}

src_install() {
	cp -pPRvf ${WORKDIR}/* ${D}/
	dosym /opt/mplayer-bin/bin/mplayer-bin /opt/mplayer-bin/bin/gmplayer-bin
	dosed dosed -e "s/gmplayer/gmplayer-bin/" /opt/mplayer-bin/share/applications/mplayer.desktop
	dosym /opt/mplayer-bin/share/applications/mplayer.desktop /usr/share/applications/mplayer-bin.desktop
	dodir /opt/mplayer-bin/lib
	dosym /usr/$(get_libdir)/win32 /opt/mplayer-bin/lib/win32
}
