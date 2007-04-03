# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-firmware/alsa-firmware-1.0.14_rc3.ebuild,v 1.2 2007/04/03 21:12:37 gustavoz Exp $

MY_P="${P/_rc/rc}"

DESCRIPTION="Advanced Linux Sound Architecture firmware"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/firmware/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 sparc ~x86"

ECHOAUDIO_CARDS="alsa_cards_darla20 alsa_cards_gina20
alsa_cards_layla20 alsa_cards_darla24 alsa_cards_gina24
alsa_cards_layla24 alsa_cards_mona alsa_cards_mia alsa_cards_indigo
alsa_cards_indigoio"

IUSE="alsa_cards_pcxhr alsa_cards_vx222 alsa_cards_usb-usx2y
alsa_cards_hdsp alsa_cards_hdspm alsa_cards_mixart alsa_cards_asihpi
alsa_cards_sb16 alsa_cards_korg1212 alsa_cards_maestro3
${ECHOAUDIO_CARDS}"

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

	local ea="no"
	for card in ${ECHOAUDIO_CARDS}; do
		use ${card} && ea="yes" && break
	done

	[[ ${ea} == "no" ]] && rm -rf "${D}/lib/firmware/ea"

	insinto /etc/udev/rules.d
	use alsa_cards_usb-usx2y && doins "${FILESDIR}/52-usx2yaudio.rules"

	dodoc README
}
