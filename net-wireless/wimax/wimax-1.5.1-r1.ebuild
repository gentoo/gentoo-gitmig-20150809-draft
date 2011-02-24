# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wimax/wimax-1.5.1-r1.ebuild,v 1.2 2011/02/24 10:42:15 alexxy Exp $

EAPI="3"

inherit linux-info base autotools

DESCRIPTION="Intel WiMAX daemon used to interface to the hardware"
HOMEPAGE="http://www.linuxwimax.org/"
SRC_URI="http://www.linuxwimax.org/Download?action=AttachFile&do=get&target=${P}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/libnl-1.1
		>=sys-kernel/linux-headers-2.6.34"
RDEPEND="${DEPEND}
		net-wireless/wimax-tools
		net-wireless/wpa_supplicant[wimax]"

PATCHES=(
		"${FILESDIR}/updates/0001-wimax-network-service-64-bit-fixes.patch"
		"${FILESDIR}/updates/0002-cleanup-fix-struct-packing-and-type-casting-issues.patch"
		"${FILESDIR}/updates/0003-Fix-pthread_mutex_unlock-duplicate-call-in-OSALTrace.patch"
		"${FILESDIR}/updates/0004-Fix-a-lot-of-warnings-about-undefined-malloc-free.patch"
		"${FILESDIR}/updates/0005-remove-duplicate-typedef-for-u8.patch"
		"${FILESDIR}/updates/0006-wimaxcu-fix-array-size.patch"
		"${FILESDIR}/updates/0007-supplicant-fix-invocation-of-eap_peer_sm_init.patch"
		"${FILESDIR}/updates/0008-supplicant-Fix-eap_methods-array-setup-and-declarati.patch"
		"${FILESDIR}/updates/0009-daemon-don-t-mask-SEGV-just-crash-and-dump-core.patch"
		"${FILESDIR}/updates/0010-OSAL-fix-OSAL_wcsmp-for-Linux-environments.patch"
		"${FILESDIR}/updates/0011-configure-remove-O2-by-default.patch"
		"${FILESDIR}/updates/0012-Allow-IP-handling-script-to-be-configurable-at-runti.patch"
		"${FILESDIR}/updates/0013-Fix-typo-in-logrotate-script.patch"
		"${FILESDIR}/updates/0014-KDapi-Big-endian-support.patch"
		"${FILESDIR}/updates/0015-Wrappers-wmx_Preambles_t-alignment.patch"
		"${FILESDIR}/updates/0016-Wrappers-wmx_SystemStateUpdate-alignment.patch"
		"${FILESDIR}/updates/0017-L4_INTEL_80216_INDICATION-typedef-redefinition.patch"
		"${FILESDIR}/updates/0018-L5Common-Big-endian-support.patch"
		"${FILESDIR}/updates/0019-Supplicant-Big-endian-support.patch"
		"${FILESDIR}/updates/0020-endianess-use-endian.h-to-determine-endianess-vs-sta.patch"
)

pkg_setup() {
	linux-info_pkg_setup
}

src_prepare() {
	for x in ${PATCHES[@]}; do
		epatch ${x}
	done
	eautoreconf
}

src_configure() {
	econf \
		--with-libwimaxll=/usr/$(get_libdir) \
		--localstatedir=/var \
		--with-i2400m=/usr || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	doinitd "${FILESDIR}"/wimax || die "failed to place the init daemon"
	sed -e "s:/usr/lib/libeap.so.0:/usr/$(get_libdir)/libeap.so.0:g" \
		-e "s:<GetDeviceTraces>3</GetDeviceTraces>:<GetDeviceTraces>0</GetDeviceTraces>:g" \
		-e "s:<OutputTarget>console</OutputTarget>:<OutputTarget>daemon</OutputTarget>:g" \
		-e "s:<IPRenew>1</IPRenew>:<IPRenew>0</IPRenew>:g" \
		-i "${D}/etc/wimax/config.xml" || die "Fixing config failed"
	# Drop udev rusles for now
	rm -rf  "${D}/etc/udev"
}
