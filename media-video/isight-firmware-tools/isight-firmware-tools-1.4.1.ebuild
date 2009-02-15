# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/isight-firmware-tools/isight-firmware-tools-1.4.1.ebuild,v 1.1 2009/02/15 19:46:08 eva Exp $

inherit autotools eutils multilib versionator

MY_MAJORV=$(get_version_component_range 1-2)
DESCRIPTION="Extract, load or export firmware for the iSight webcams"
HOMEPAGE="http://bersace03.free.fr/ift/"
SRC_URI="http://launchpad.net/${PN}/main/${MY_MAJORV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.14
	dev-libs/libusb
	dev-libs/libgcrypt"
#	>=sys-apps/hal-0.5.9"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35.5
	sys-apps/texinfo"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix forced as-needed build, bug #247904
	epatch "${FILESDIR}/${PN}-1.2-ift-ldadd.patch"

	sed "s:/lib/firmware:/$(get_libdir)/firmware:" \
		-i src/isight.rules.in.in || die "sed failed"

	eautomake
}

src_compile() {
	# https://bugs.launchpad.net/isight-firmware-tools/+bug/243255
	econf --enable-udev --disable-hal --docdir="${ROOT}/usr/share/doc/${P}"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	mv "${D}"/etc/udev/rules.d/isight.rules "${D}"/etc/udev/rules.d/70-isight.rules
	rm -f "${D}/usr/share/doc/${P}/HOWTO"
	dodoc AUTHORS ChangeLog HOWTO NEWS README
}

pkg_postinst() {
	elog "You need to extract your firmware prior to being able to loading it"
	elog "ift-extract --apple-driver /macos/System/Library/Extensions/IOUSBFamily.kext/Contents/PlugIns/AppleUSBVideoSupport.kext/Contents/MacOS/AppleUSBVideoSupport"
	elog "If you do not have OSX you can get AppleUSBVideoSupport from"
	elog "http://www.mediafire.com/?81xtkqyttjt"
}
