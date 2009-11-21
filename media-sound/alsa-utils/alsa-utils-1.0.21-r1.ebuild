# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-1.0.21-r1.ebuild,v 1.1 2009/11/21 12:49:21 ayoy Exp $

EAPI=2
inherit eutils

MY_P=${P/_rc/rc}

DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/utils/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0.9"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="doc nls minimal"

DEPEND=">=sys-libs/ncurses-5.1
	dev-util/dialog
	>=media-libs/alsa-lib-${PV}
	doc? ( app-text/xmlto )"
RDEPEND=">=sys-libs/ncurses-5.1
	dev-util/dialog
	>=media-libs/alsa-lib-${PV}
	virtual/modutils
	!minimal? ( sys-apps/pciutils )"

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if [[ -e "${ROOT}etc/modules.d/alsa" ]]; then
		eerror "Obsolete config /etc/modules.d/alsa found."
		die "Move /etc/modules.d/alsa to /etc/modprobe.d/alsa.conf."
	fi

	if [[ -e "${ROOT}etc/modprobe.d/alsa" ]]; then
		eerror "Obsolete config /etc/modprobe.d/alsa found."
		die "Move /etc/modprobe.d/alsa to /etc/modprobe.d/alsa.conf."
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-modprobe.d.patch \
		"${FILESDIR}"/${P}-init_default.patch
}

src_configure() {
	local myconf=""
	use doc || myconf="--disable-xmlto"

	econf ${myconf} \
		$(use_enable nls)
}

src_install() {
	local ALSA_UTILS_DOCS="ChangeLog README TODO
		seq/aconnect/README.aconnect
		seq/aseqnet/README.aseqnet"

	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ${ALSA_UTILS_DOCS} || die

	newinitd "${FILESDIR}/alsasound.initd-r4" alsasound
	newconfd "${FILESDIR}/alsasound.confd-r3" alsasound
	insinto /etc/modprobe.d
	newins "${FILESDIR}/alsa-modules.conf-rc" alsa.conf

	keepdir /var/lib/alsa
}

pkg_postinst() {
	echo
	elog "To take advantage of the init script, and automate the process of"
	elog "saving and restoring sound-card mixer levels you should"
	elog "add alsasound to the boot runlevel. You can do this as"
	elog "root like so:"
	elog "	# rc-update add alsasound boot"
	echo
	elog "The script will load ALSA modules, if you choose to use a modular"
	elog "configuration. The Gentoo ALSA developers recommend you to build"
	elog "your audio drivers into the kernel unless the device is hotpluggable"
	elog "or you need to supply specific options (such as model= to HD Audio)."
	echo
	ewarn "Automated unloading of ALSA modules is deprecated and unsupported."
	ewarn "Should you choose to use it, bug reports will not be accepted."
	echo
	if use minimal; then
		ewarn "The minimal use flag disables the dependency on pciutils that"
		ewarn "is needed by alsaconf at runtime."
	fi
}
