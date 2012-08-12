# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/isight-firmware-tools/isight-firmware-tools-1.6-r1.ebuild,v 1.1 2012/08/12 06:42:08 ssuominen Exp $

EAPI=4
inherit eutils multilib versionator toolchain-funcs

MY_MAJORV="$(get_version_component_range 1).6"
DESCRIPTION="Extract, load or export firmware for the iSight webcams"
HOMEPAGE="https://launchpad.net/isight-firmware-tools"
SRC_URI="http://launchpad.net/${PN}/main/${MY_MAJORV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.14:2
	dev-libs/libgcrypt
	>=sys-fs/udev-149
	virtual/libusb:0"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	sys-apps/texinfo
	virtual/pkgconfig"

src_prepare() {
	# Fix multilib support
	sed -i \
		-e "s:/lib/firmware:/$(get_libdir)/firmware:" \
		src/isight.rules.in.in || die

	# Fix build with -O0, bug #221325
	epatch "${FILESDIR}"/${PN}-1.5.90-build-O0.patch

	# Fix for systems with lib64 but no symlink to lib
	sed -i \
		-e "s:@udevdir@:$($(tc-getPKG_CONFIG) --variable=udevdir udev):" \
		src/isight.rules.in.in || die
}

src_configure() {
	# https://bugs.launchpad.net/isight-firmware-tools/+bug/243255
	econf --docdir=/usr/share/doc/${PF}
}

src_install() {
	local udevdir="$($(tc-getPKG_CONFIG) --variable=udevdir udev)"

	emake \
		DESTDIR="${D}" \
		libudevdir="${udevdir}" \
		rulesdir="${udevdir}"/rules.d \
		install

	mv -vf "${D}"/"${udevdir}"/rules.d/{isight.rules,70-isight.rules}

	dodoc AUTHORS ChangeLog HOWTO NEWS README
	rm -f "${D}"/usr/share/doc/${PF}/HOWTO
}

pkg_postinst() {
	elog "You need to extract your firmware prior to being able to loading it"
	elog "ift-extract --apple-driver /macos/System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBVideoSupport.kext/Contents/MacOS/AppleUSBVideoSupport"
	elog "If you do not have OSX you can get AppleUSBVideoSupport from"
	elog "http://www.mediafire.com/?81xtkqyttjt"
}
