# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/pm-utils/pm-utils-1.3.0.ebuild,v 1.1 2010/04/04 16:10:25 scarabeus Exp $

EAPI="2"

inherit autotools base

DESCRIPTION="Suspend and hibernation utilities for HAL"
HOMEPAGE="http://pm-utils.freedesktop.org/"
SRC_URI="http://pm-utils.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="alsa debug doc networkmanager ntp video_cards_intel video_cards_radeon"

RDEPEND="
	!sys-power/powermgmt-base
	sys-apps/dbus
	>=sys-apps/util-linux-2.13
	sys-power/pm-quirks
	alsa? ( media-sound/alsa-utils )
	networkmanager? ( net-misc/networkmanager )
	ntp? ( net-misc/ntp )
"
DEPEND="doc? ( app-text/xmlto )"

PATCHES=(
	"${FILESDIR}/${PV}-fix_autotools.patch"
)

src_prepare() {
	local ignore="01grub"
	use networkmanager || ignore+=" 55NetworkManager"
	use ntp || ignore+=" 90clock"

	use debug && echo 'PM_DEBUG="true"' > "${S}/gentoo"
	echo "HOOK_BLACKLIST=\"${ignore}\"" >> "${S}/gentoo"

	# write makefile patch
	base_src_prepare

	eautoreconf
}

src_configure() {
	econf \
		$(use_enable doc)
}

src_install() {
	base_src_install

	dodoc AUTHORS ChangeLog NEWS README* TODO || die "dodoc failed"

	insinto /etc/pm/config.d/
	doins "${S}/gentoo" || die "doins failed"
}
