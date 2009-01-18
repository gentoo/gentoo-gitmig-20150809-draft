# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/pm-utils/pm-utils-1.2.3-r1.ebuild,v 1.1 2009/01/18 20:21:37 eva Exp $

DESCRIPTION="Suspend and hibernation utilties for HAL"
HOMEPAGE="http://pm-utils.freedesktop.org/"
SRC_URI="http://pm-utils.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
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

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fix pkg-config file, bug #254492
	sed -e 's:${pm_libdir):${pm_libdir}:' -i pm-utils.pc.in || die "sed failed"

	local ignore="01grub"
	use networkmanager || ignore="${ignore} 55NetworkManager"
	use ntp            || ignore="${ignore} 90clock"

	touch "${S}/gentoo"
	use debug && echo 'PM_DEBUG="true"' >> "${S}/gentoo"
	echo "HOOK_BLACKLIST=\"${ignore}\"" >> "${S}/gentoo"
}

src_compile() {
	econf
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README* TODO || die "dodoc failed"

	insinto /etc/pm/config.d/
	doins "${S}/gentoo"
}
