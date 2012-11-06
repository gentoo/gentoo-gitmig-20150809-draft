# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-1.0.26-r1.ebuild,v 1.1 2012/11/06 23:17:02 vapier Exp $

EAPI=4
inherit eutils systemd toolchain-funcs

DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/utils/${P}.tar.bz2
	!minimal? ( mirror://alsaproject/driver/alsa-driver-1.0.25.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0.9"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="doc +libsamplerate minimal +ncurses nls selinux"

COMMON_DEPEND=">=media-libs/alsa-lib-${PV}
	libsamplerate? ( media-libs/libsamplerate )
	ncurses? ( >=sys-libs/ncurses-5.7-r7 )
	selinux? ( sec-policy/selinux-alsa )"
RDEPEND="${COMMON_DEPEND}
	!minimal? (
		dev-util/dialog
		sys-apps/pciutils
	)"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	doc? ( app-text/xmlto )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-1.0.23-modprobe.d.patch \
		"${FILESDIR}"/${PN}-1.0.25-separate-usr-var-fs.patch
}

src_configure() {
	local myconf
	use doc || myconf='--disable-xmlto'

	local udevdir=/lib/udev
	has_version sys-fs/udev && udevdir="$($(tc-getPKG_CONFIG) --variable=udevdir udev)"

	econf \
		$(use_enable libsamplerate alsaloop) \
		$(use_enable nls) \
		$(use_enable ncurses alsamixer) \
		$(use_enable !minimal alsaconf) \
		"$(systemd_with_unitdir)" \
		--with-udev-rules-dir="${udevdir}"/rules.d \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc ChangeLog README TODO seq/*/README.*

	use minimal || newbin "${WORKDIR}"/alsa-driver-*/utils/alsa-info.sh alsa-info

	newinitd "${FILESDIR}"/alsasound.initd-r5 alsasound
	newconfd "${FILESDIR}"/alsasound.confd-r4 alsasound

	insinto /etc/modprobe.d
	newins "${FILESDIR}"/alsa-modules.conf-rc alsa.conf

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
	ewarn "The ALSA core should be built into the kernel or loaded through other"
	ewarn "means. There is no longer any modular auto(un)loading in alsa-utils."
	echo
}
