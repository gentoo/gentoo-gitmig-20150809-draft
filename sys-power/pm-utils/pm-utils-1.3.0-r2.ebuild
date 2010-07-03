# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/pm-utils/pm-utils-1.3.0-r2.ebuild,v 1.9 2010/07/03 21:32:49 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Suspend and hibernation utilities"
HOMEPAGE="http://pm-utils.freedesktop.org/"
SRC_URI="http://pm-utils.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ppc64 x86"
IUSE="alsa debug networkmanager ntp video_cards_intel video_cards_radeon"

vbetool="!video_cards_intel? ( sys-apps/vbetool )"
RDEPEND="
	!sys-power/powermgmt-base
	sys-apps/dbus
	>=sys-apps/util-linux-2.13
	sys-power/pm-quirks
	alsa? ( media-sound/alsa-utils )
	networkmanager? ( net-misc/networkmanager )
	ntp? ( net-misc/ntp )
	amd64? ( ${vbetool} )
	x86? ( ${vbetool} )
	video_cards_radeon? ( app-laptop/radeontool )"
DEPEND="app-text/xmlto
	app-text/docbook-xml-dtd:4.5"

src_prepare() {
	local ignore="01grub"
	use networkmanager || ignore+=" 55NetworkManager"
	use ntp || ignore+=" 90clock"

	use debug && echo 'PM_DEBUG="true"' > "${S}/gentoo"
	echo "HOOK_BLACKLIST=\"${ignore}\"" >> "${S}/gentoo"

	epatch "${FILESDIR}"/${PV}-fix_autotools.patch \
		"${FILESDIR}"/${PV}-on_ac_power-upower.patch

	eautoreconf
}

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS pm/HOWTO* README* TODO || die

	insinto /etc/pm/config.d
	doins gentoo || die
}
