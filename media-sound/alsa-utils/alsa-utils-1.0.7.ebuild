# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-1.0.7.ebuild,v 1.2 2004/11/22 18:56:24 eradicator Exp $

IUSE=""

MY_P=${P/_rc/rc}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/utils/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0.9"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 sparc ~x86"

DEPEND=">=sys-libs/ncurses-5.1
	dev-util/dialog
	>=media-libs/alsa-lib-1.0.3"

RDEPEND="${DEPEND}
	sys-apps/pciutils"

src_install() {
	local ALSA_UTILS_DOCS="ChangeLog README TODO
		seq/aconnect/README.aconnect
		seq/aseqnet/README.aseqnet"

	make DESTDIR="${D}" install || die "Installation Failed"

	dodoc ${ALSA_UTILS_DOCS}
	newdoc alsamixer/README README.alsamixer

	insinto /etc/conf.d
	newins ${FILESDIR}/alsasound.confd alsasound
	insinto /etc/modules.d
	newins ${FILESDIR}/alsa-modules.conf-rc alsa
	exeinto /etc/init.d
	doexe ${FILESDIR}/alsasound
}

pkg_postinst() {
	echo
	einfo "The alsasound initscript is now provided by alsa-utils"
	einfo "instead of alsa-driver for compatibility with kernel-sources"
	einfo "which provide ALSA internally."
	echo
	einfo "To take advantage of this, and automate the process of"
	einfo "loading and unloading the ALSA sound drivers as well as"
	einfo "storing and restoring sound-card mixer levels you should"
	einfo "add alsasound to the boot runlevel. You can do this as"
	einfo "root like so:"
	einfo "	# rc-update add alsasound boot"
	echo
	einfo "You will also need to edit the file /etc/modules.d/alsa"
	einfo "and run modules-update. You can do this like so:"
	einfo "	# nano -w /etc/modules.d/alsa && modules-update"
	echo
}
