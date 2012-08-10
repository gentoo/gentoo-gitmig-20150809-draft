# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsa-utils/alsa-utils-1.0.25-r3.ebuild,v 1.1 2012/08/10 17:24:24 ssuominen Exp $

EAPI=4
inherit base systemd toolchain-funcs

MY_P=${P/_rc/rc}

DESCRIPTION="Advanced Linux Sound Architecture Utils (alsactl, alsamixer, etc.)"
HOMEPAGE="http://www.alsa-project.org/"
SRC_URI="mirror://alsaproject/utils/${MY_P}.tar.bz2
	mirror://alsaproject/driver/alsa-driver-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0.9"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="doc nls minimal selinux"

COMMON_DEPEND=">=sys-libs/ncurses-5.1
	dev-util/dialog
	>=media-libs/alsa-lib-1.0.25
	media-libs/libsamplerate
	selinux? ( sec-policy/selinux-alsa )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	doc? ( app-text/xmlto )"
RDEPEND="${COMMON_DEPEND}
	!minimal? ( sys-apps/pciutils )"

S="${WORKDIR}/${MY_P}"
PATCHES=(
"${FILESDIR}/${PN}-1.0.23-modprobe.d.patch"
"${FILESDIR}/${P}-separate-usr-var-fs.patch"
)

src_configure() {
	local myconf=""
	use doc || myconf="--disable-xmlto"

	local udevdir=/lib/udev
	has_version sys-fs/udev && udevdir="$($(tc-getPKG_CONFIG) --variable=udevdir udev)"

	econf ${myconf} \
		$(use_enable nls) \
		$(use_enable !minimal alsaconf) \
		"$(systemd_with_unitdir)" \
		--with-udev-rules-dir="${udevdir}"/rules.d
}

src_install() {
	local ALSA_UTILS_DOCS="ChangeLog README TODO
		seq/aconnect/README.aconnect
		seq/aseqnet/README.aseqnet"

	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc ${ALSA_UTILS_DOCS} || die

	newbin "${WORKDIR}/alsa-driver-${PV}/utils/alsa-info.sh" \
		alsa-info

	newinitd "${FILESDIR}/alsasound.initd-r5" alsasound
	newconfd "${FILESDIR}/alsasound.confd-r4" alsasound
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
	ewarn "The ALSA core should be built into the kernel or loaded through other"
	ewarn "means. There is no longer any modular auto(un)loading in alsa-utils."
	echo
	if use minimal; then
		ewarn "The minimal use flag disables the dependency on pciutils that"
		ewarn "is needed by alsaconf at runtime."
	fi
}
