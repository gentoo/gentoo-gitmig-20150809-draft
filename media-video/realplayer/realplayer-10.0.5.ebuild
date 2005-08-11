# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/realplayer/realplayer-10.0.5.ebuild,v 1.5 2005/08/11 20:20:00 flameeyes Exp $

inherit nsplugins eutils rpm

MY_PN="RealPlayer"
DESCRIPTION="Real Media Player"
HOMEPAGE="https://player.helixcommunity.org/2004/downloads/"
SRC_URI="https://helixcommunity.org/download.php/1343/${MY_PN}-${PV}.756-20050513.i586.rpm"
LICENSE="HBRL"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="nsplugin"

# take this out until I get the realplayer source
# build sorted out. - ChrisWhite
# RDEPEND="!media-video/realplayer
RDEPEND=">=dev-libs/glib-2
		>=x11-libs/pango-1.2
		>=x11-libs/gtk+-2.2
		amd64? ( app-emulation/emul-linux-x86-gtklibs )"
DEPEND="${RDEPEND}"
RESTRICT="nostrip nomirror"

S=${WORKDIR}/usr/local/${MY_PN}

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

src_unpack() {
	rpm_src_unpack

	sed -i -e 's:realplay.png:realplay:' ${S}/share/realplay.desktop
}

src_install() {
	dodir /opt/${MY_PN}
	mv * ${D}/opt/${MY_PN}

	dodir /usr/bin
	dosym /opt/${MY_PN}/realplay /usr/bin/realplay

	cd ${D}/opt/${MY_PN}/share
	domenu realplay.desktop

	for res in 16 192 32 48; do
		insinto /usr/share/icons/hicolor/${res}x${res}/apps
		newins icons/realplay_${res}x${res}.png \
				realplay.png
	done

	# mozilla plugin
	if use nsplugin ; then
		cd ${D}/opt/${MY_PN}/mozilla
		exeinto /opt/netscape/plugins
		doexe nphelix.so
		inst_plugin /opt/netscape/plugins/nphelix.so
	fi

	# Language resources
	cd ${D}/opt/RealPlayer/share/locale
	for LC in *; do
		mkdir -p ${D}/usr/share/locale/${LC}/LC_MESSAGES
		dosym /opt/RealPlayer/share/locale/${LC}/player.mo /usr/share/locale/${LC}/LC_MESSAGES/realplay.mo
		dosym /opt/RealPlayer/share/locale/${LC}/widget.mo /usr/share/locale/${LC}/LC_MESSAGES/libgtkhx.mo
	done
}
