# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/mozilla-sunbird-bin/mozilla-sunbird-bin-0.3.ebuild,v 1.2 2007/02/14 19:18:51 armin76 Exp $

inherit eutils mozilla-launcher multilib

DESCRIPTION="The Mozilla Sunbird Calendar"
SRC_URI="http://releases.mozilla.org/pub/mozilla.org/calendar/sunbird/releases/${PV}/linux-i686/en-US/sunbird-${PV}.en-US.linux-i686.tar.bz2"
HOMEPAGE="http://www.mozilla.org/projects/calendar/sunbird.html"
RESTRICT="nostrip"

KEYWORDS="-* ~amd64 x86"
SLOT="0"
LICENSE="MPL-1.1 GPL-2 LGPL-2.1"
IUSE=""

DEPEND=""
RDEPEND="x11-libs/libXcursor
	x11-libs/libXrandr
	x11-libs/libXi
	x11-libs/libXinerama
	x11-libs/libXt
	virtual/xft
	x86? (
		>=x11-libs/gtk+-2.2
		=virtual/libstdc++-3.3
	)
	amd64? (
		>=app-emulation/emul-linux-x86-baselibs-1.0
		>=app-emulation/emul-linux-x86-gtklibs-1.0
	)
	>=www-client/mozilla-launcher-1.44"

S=${WORKDIR}/sunbird

pkg_config() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

src_install() {
	declare MOZILLA_FIVE_HOME=/opt/sunbird

	# Install sunbird in /opt
	dodir ${MOZILLA_FIVE_HOME%/*}
	mv ${S} ${D}${MOZILLA_FIVE_HOME}

	keepdir ${MOZILLA_FIVE_HOME}/extensions		# required to run!

	# Create /usr/bin/sunbird-bin
	install_mozilla_launcher_stub sunbird-bin ${MOZILLA_FIVE_HOME}

	# Install icon and .desktop for menu entry
	doicon ${FILESDIR}/icon/mozilla-sunbird-bin-icon.png
	domenu ${FILESDIR}/icon/mozilla-sunbird-bin.desktop
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME=/opt/sunbird

	# Remove entire installed instance to prevent all kinds of
	# problems... see bug 44772 for example
	rm -rf ${ROOT}${MOZILLA_FIVE_HOME}
}

pkg_postinst() {
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	update_mozilla_launcher_symlinks
}
