# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-firmware/alsa-firmware-1.0.23.ebuild,v 1.4 2010/11/08 21:13:39 jer Exp $

MY_P="${P/_rc/rc}"

DESCRIPTION="Advanced Linux Sound Architecture firmware"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/firmware/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"

ECHOAUDIO_CARDS="alsa_cards_darla20 alsa_cards_gina20
alsa_cards_layla20 alsa_cards_darla24 alsa_cards_gina24
alsa_cards_layla24 alsa_cards_mona alsa_cards_mia alsa_cards_indigo
alsa_cards_indigoio alsa_cards_echo3g"

EMU_CARDS="alsa_cards_emu1212 alsa_cards_emu1616 alsa_cards_emu1820
alsa_cards_emu10k1"

IUSE="alsa_cards_pcxhr alsa_cards_vx222 alsa_cards_usb-usx2y
alsa_cards_hdsp alsa_cards_hdspm alsa_cards_mixart alsa_cards_asihpi
alsa_cards_sb16 alsa_cards_korg1212 alsa_cards_maestro3 alsa_cards_emi26
alsa_cards_ymfpci alsa_cards_wavefront alsa_cards_msnd-pinnacle
alsa_cards_aica ${ECHOAUDIO_CARDS} ${EMU_CARDS}"

S="${WORKDIR}/${MY_P}"

DEPEND=""
RDEPEND="alsa_cards_usb-usx2y? ( sys-apps/fxload )
	alsa_cards_hdsp? ( media-sound/alsa-tools )
	alsa_cards_hdspm? ( media-sound/alsa-tools )
	alsa_cards_mixart? ( || ( >=sys-fs/udev-096 media-sound/alsa-tools ) )
	alsa_cards_vx222? ( || ( >=sys-fs/udev-096 media-sound/alsa-tools ) )
	alsa_cards_pcxhr? ( || ( >=sys-fs/udev-096 >=media-sound/alsa-tools-1.0.14_rc1-r1 ) )"

src_compile() {
	econf \
		--with-hotplug-dir=/lib/firmware \
		|| die "configure failed"

	emake || die "make failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"

	use alsa_cards_pcxhr || rm -rf "${D}/usr/share/alsa/firmware/pcxhrloader" "${D}/lib/firmware/pcxhr"
	use alsa_cards_vx222 || rm -rf "${D}/usr/share/alsa/firmware/vxloader" "${D}/lib/firmware/vx"
	use alsa_cards_usb-usx2y || rm -rf "${D}/usr/share/alsa/firmware/usx2yloader" "${D}/lib/firmware/vx"
	use alsa_cards_mixart || rm -rf "${D}/usr/share/alsa/firmware/mixartloader" "${D}/lib/firmware/mixart"
	use alsa_cards_hdsp || use alsa_cards_hdspm || rm -rf "${D}/usr/share/alsa/firmware/hdsploader"
	use alsa_cards_asihpi || rm -rf "${D}/lib/firmware/asihpi"
	use alsa_cards_sb16 || rm -rf "${D}/lib/firmware/sb16"
	use alsa_cards_korg1212 || rm -rf "${D}/lib/firmware/korg"
	use alsa_cards_maestro3 || rm -rf "${D}/lib/firmware/ess"
	use alsa_cards_emi26 || rm -rf "${D}lib/firmware/emagic"
	use alsa_cards_ymfpci || rm -rf "${D}lib/firmware/yamaha"
	use alsa_cards_wavefront || rm -rf "${D}/lib/firmware/wavefront"
	use alsa_cards_msnd-pinnacle || rm -rf "${D}/lib/firmware/turtlebeach"
	use alsa_cards_aica || rm -rf "${D}/lib/firmware/aica_firmware.bin"

	local ea="no"
	for card in ${ECHOAUDIO_CARDS}; do
		use ${card} && ea="yes" && break
	done

	local emu="no"
	for card in ${EMU_CARDS}; do
		use ${card} && emu="yes" && break
	done

	[[ ${ea} == "no" ]] && rm -rf "${D}/lib/firmware/ea"
	[[ ${emu} == "no" ]] && rm -rf "${D}/lib/firmware/emu"

	insinto /etc/udev/rules.d
	use alsa_cards_usb-usx2y && doins "${FILESDIR}/52-usx2yaudio.rules"

	dodoc README || die
}
