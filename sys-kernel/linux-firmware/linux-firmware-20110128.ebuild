# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-firmware/linux-firmware-20110128.ebuild,v 1.1 2011/02/19 20:30:46 chithanh Exp $

EAPI=3

DESCRIPTION="Linux firmware files"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/dwmw2/firmware"

if [[ ${PV} == 99999999* ]]; then
	inherit git
	SRC_URI=""
	EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/dwmw2/${PN}.git"
else
	SRC_URI="mirror://kernel/linux/kernel/people/dwmw2/firmware/${P}.tar.bz2"
fi

LICENSE="GPL-1 GPL-2 GPL-3 BSD freedist"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="!media-sound/alsa-firmware[alsa_cards_korg1212]
	!media-sound/alsa-firmware[alsa_cards_maestro3]
	!media-sound/alsa-firmware[alsa_cards_sb16]
	!media-sound/alsa-firmware[alsa_cards_ymfpci]
	!media-tv/ivtv-firmware
	!media-tv/linuxtv-dvb-firmware[dvb_cards_cx231xx]
	!media-tv/linuxtv-dvb-firmware[dvb_cards_cx23885]
	!media-tv/linuxtv-dvb-firmware[dvb_cards_usb-dib0700]
	!net-wireless/libertas-firmware
	!net-wireless/i2400m-fw
	!net-wireless/iwl1000-ucode
	!net-wireless/iwl3945-ucode
	!net-wireless/iwl4965-ucode
	!net-wireless/iwl5000-ucode
	!net-wireless/iwl5150-ucode
	!net-wireless/iwl6000-ucode
	!net-wireless/iwl6050-ucode
	!net-wireless/rt61-firmware
	!net-wireless/rt73-firmware
	!sys-block/qla-fc-firmware
	!x11-drivers/radeon-ucode"
#add anything else that collides to this

src_install() {
	insinto /lib/firmware/
	doins -r * || die "Install failed!"
}
