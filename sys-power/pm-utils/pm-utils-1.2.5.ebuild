# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/pm-utils/pm-utils-1.2.5.ebuild,v 1.10 2010/06/23 11:55:02 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Suspend and hibernation utilities for HAL"
HOMEPAGE="http://pm-utils.freedesktop.org/"
SRC_URI="http://pm-utils.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc64"
IUSE="alsa debug networkmanager ntp video_cards_intel video_cards_radeon"

RDEPEND=">=sys-apps/hal-0.5.10
	>=sys-apps/dbus-1.0.0
	!sys-power/powermgmt-base
	>=sys-apps/util-linux-2.13
	alsa? ( media-sound/alsa-utils )
	networkmanager? ( net-misc/networkmanager )
	ntp? ( net-misc/ntp )
	!ppc? (
		!ppc64? (
			!video_cards_intel? ( sys-apps/vbetool )
			video_cards_radeon? ( app-laptop/radeontool )
		)
	)"
DEPEND="!sys-power/powermgmt-base"
# XXX: app-text/xmlto usage is automagic

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

src_configure() {
	econf --docdir=/usr/share/doc/${P}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README* TODO || die "dodoc failed"

	insinto /etc/pm/config.d/
	doins "${S}/gentoo" || die "doins failed"
}
