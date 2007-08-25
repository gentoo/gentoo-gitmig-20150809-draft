# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/realplayer/realplayer-10.0.9.ebuild,v 1.1 2007/08/25 14:02:15 beandog Exp $

inherit nsplugins eutils rpm

MY_PN="RealPlayer"
DESCRIPTION="Real Media Player"
HOMEPAGE="https://player.helixcommunity.org/2005/downloads/"
SRC_URI="RealPlayer-10.0.9.809-20070726.i586.rpm"
LICENSE="HBRL"
SLOT="0"
KEYWORDS="-* amd64 ~x86"
IUSE="X nsplugin"
RDEPEND="!amd64? (
			X? ( >=dev-libs/glib-2
				>=x11-libs/pango-1.2
				>=x11-libs/gtk+-2.2 )
			=virtual/libstdc++-3.3*
		)
		amd64? (
			X? ( app-emulation/emul-linux-x86-gtklibs )
			app-emulation/emul-linux-x86-compat
		)"
RESTRICT="strip test fetch"

QA_TEXTRELS="opt/RealPlayer/codecs/raac.so
	opt/RealPlayer/codecs/cvt1.so
	opt/RealPlayer/codecs/colorcvt.so
	opt/RealPlayer/codecs/drv2.so
	opt/RealPlayer/codecs/drvc.so
	opt/RealPlayer/plugins/theorarend.so
	opt/RealPlayer/plugins/vorbisrend.so
	opt/RealPlayer/plugins/swfrender.so
	opt/RealPlayer/plugins/vidsite.so
	opt/RealPlayer/plugins/oggfformat.so"

S="${WORKDIR}/usr/local/${MY_PN}"

pkg_nofetch() {
	einfo "Download RealPlayer manually from Real's website at"
	einfo ${DOWNLOADPAGE}
	einfo ""
	einfo "Choose Linux/x86 Releases: RealPlayer 10.0.9 Gold: RPM"
	einfo "https://helixcommunity.org/projects/player/files/download/2479"
	einfo ""
	einfo "Then place the file ${SRC_URI}"
	einfo "into ${DISTDIR} and restart the emerge."
}

pkg_setup() {
	# This is a binary x86 package => ABI=x86
	# Please keep this in future versions
	# Danny van Dyk <kugelfang@gentoo.org> 2005/03/26
	has_multilib_profile && ABI="x86"
}

src_unpack() {
	rpm_src_unpack

	dosed -i -e 's:realplay.png:realplay:' ${S}/share/realplay.desktop
}

src_install() {
	dodir /opt/${MY_PN}

	fperms 644 codecs/*
	insinto /opt/${MY_PN}/codecs
	doins codecs/*
	for x in drvc drv2 atrc sipr; do
		dosym ${x}.so /opt/${MY_PN}/codecs/${x}.so.6.0
	done

	cd ${S}
	dodoc README
	dohtml share/hxplay_help.html share/tigris.css

	if use X; then
		for x in common lib mozilla plugins postinst realplay realplay.bin share; do
			mv $x ${D}/opt/${MY_PN}
		done;

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

			insinto /opt/netscape/plugins
			doins nphelix.xpt
			inst_plugin /opt/netscape/plugins/nphelix.xpt
		fi

		# Language resources
		cd ${D}/opt/RealPlayer/share/locale
		for LC in *; do
			mkdir -p ${D}/usr/share/locale/${LC}/LC_MESSAGES
			dosym /opt/RealPlayer/share/locale/${LC}/player.mo /usr/share/locale/${LC}/LC_MESSAGES/realplay.mo
			dosym /opt/RealPlayer/share/locale/${LC}/widget.mo /usr/share/locale/${LC}/LC_MESSAGES/libgtkhx.mo
		done
	fi
}
