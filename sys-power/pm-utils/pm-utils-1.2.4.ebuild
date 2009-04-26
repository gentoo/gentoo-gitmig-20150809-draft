# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/pm-utils/pm-utils-1.2.4.ebuild,v 1.4 2009/04/26 19:19:31 ranger Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Suspend and hibernation utilties for HAL"
HOMEPAGE="http://pm-utils.freedesktop.org/"
SRC_URI="http://pm-utils.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="alsa debug networkmanager ntp video_cards_intel video_cards_radeon"

RDEPEND=">=sys-apps/hal-0.5.10
	>=sys-apps/dbus-1.0.0
	!sys-power/powermgmt-base
	>=sys-apps/util-linux-2.13
	alsa? ( media-sound/alsa-utils )
	networkmanager? ( net-misc/networkmanager )
	ntp? ( net-misc/ntp )
	!ppc? (
		!video_cards_intel? ( sys-apps/vbetool )
		video_cards_radeon? ( app-laptop/radeontool )
	)"
DEPEND="!sys-power/powermgmt-base
	app-text/xmlto"

src_prepare() {
	local ignore="01grub"
	use networkmanager || ignore="${ignore} 55NetworkManager"
	use ntp            || ignore="${ignore} 90clock"

	touch "${S}/gentoo"
	use debug && echo 'PM_DEBUG="true"' >> "${S}/gentoo"
	echo "HOOK_BLACKLIST=\"${ignore}\"" >> "${S}/gentoo"

	# Be a bit more future proof, bug #260943
	sed "s/-Werror//" -i configure.ac || die "sed failed"

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README* TODO || die "dodoc failed"

	insinto /etc/pm/config.d/
	doins "${S}/gentoo" || die "doins failed"
}
