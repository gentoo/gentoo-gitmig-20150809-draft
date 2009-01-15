# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/pm-utils/pm-utils-1.1.1.ebuild,v 1.3 2009/01/15 22:06:51 maekke Exp $

inherit autotools eutils

DESCRIPTION="Suspend and hibernation utilties for HAL"
HOMEPAGE="http://pm-utils.freedesktop.org/"
SRC_URI="http://pm-utils.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="alsa debug networkmanager ntp video_cards_intel video_cards_radeon"

RDEPEND=">=sys-apps/hal-0.5.10
		 >=sys-apps/dbus-1.0.0
		 !sys-power/powermgmt-base
		 >=sys-apps/util-linux-2.13
		 alsa? ( media-sound/alsa-utils )
		 networkmanager? ( net-misc/networkmanager )
		 ntp? ( net-misc/ntp )
		 !video_cards_intel? ( sys-apps/vbetool )
		 video_cards_radeon? ( app-laptop/radeontool )"
DEPEND="!sys-power/powermgmt-base"

src_unpack() {
	local ignore="01grub"

	unpack ${A}
	cd "${S}"

	touch "${S}/gentoo"

	use debug && echo 'PM_DEBUG="true"' > "${S}/gentoo"

	use alsa           || ignore="${ignore} 60alsa"
	use networkmanager || ignore="${ignore} 10NetworkManager"
	use ntp            || ignore="${ignore} 90clock"

	echo "HOOK_BLACKLIST=\"${ignore}\"" > "${S}/gentoo"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	insinto /etc/pm/config.d/
	doins "${S}/gentoo"
}
