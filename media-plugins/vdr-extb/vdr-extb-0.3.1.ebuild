# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-extb/vdr-extb-0.3.1.ebuild,v 1.1 2010/12/02 15:10:01 hd_brummy Exp $

EAPI="2"

inherit vdr-plugin

DESCRIPTION="VDR Plugin: used to control the VDR Extension Board"
HOMEPAGE="http://www.deltab.de/content/view/74/76/"
SRC_URI="http://www.deltab.de/component/option,com_docman/task,doc_download/gid,102/ -> "${P}".tar.gz
		mirror://vdrfiles/${PN}/extb_firmware_1.08_lircd.conf.zip
		mirror://vdrfiles/${PN}/extb.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0
	app-misc/lirc"

src_prepare() {
	vdr-plugin_src_prepare

	cd "${WORKDIR}"
	epatch "${FILESDIR}/${P}-gentoo.diff"
	epatch "${FILESDIR}/${P}_vdr-1.7.13.diff"
}

src_install() {
	vdr-plugin_src_install

	dodoc README.de
	dodoc "${S}/../lircd.conf.extb_FW1.08"
	docinto wakeup
	dodoc "${S}/wakeup/README.de"

	dobin "${S}/../extb/bin/extb.sh"
	dobin "${S}/../extb/bin/picdl"
	dobin "${S}/../extb/bin/status.sh"
	dobin "${S}/../extb/bin/tx.sh"
	dobin "${S}/wakeup/extb-poweroff.pl"
	dobin "${S}/wakeup/examples/checkscript.sh"

	insinto /usr/share/extb/
	doins "${S}/../extb_1.08.hex"

	insinto /etc/extb
	doins "${S}/../extb/bin/PICflags.conf"
	doins "${S}/wakeup/examples/extb-poweroff.conf"
}

pkg_postinst() {
	vdr-plugin_pkg_postinst

	einfo
	einfo "You need to upload the included firmware (1.08)"
	einfo "(you will find it in /usr/share/extb/)"
	einfo "into the extension board and update your lircd.conf"
	einfo "See the supplied lircd.conf.extb_FW1.08 in"
	einfo "/usr/share/doc/vdrplugin-extb"
}
