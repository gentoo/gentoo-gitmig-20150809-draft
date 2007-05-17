# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ndiswrapper/ndiswrapper-1.44.ebuild,v 1.1 2007/05/17 16:57:18 peper Exp $

inherit linux-mod

DESCRIPTION="Wrapper for using Windows drivers for some wireless cards"
HOMEPAGE="http://ndiswrapper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="debug usb"

DEPEND="sys-apps/pciutils"
RDEPEND="${DEPEND}
	net-wireless/wireless-tools"

CONFIG_CHECK="NET_RADIO"

MODULE_NAMES="ndiswrapper(misc:${S}/driver)"
BUILD_TARGETS="all"
MODULESD_NDISWRAPPER_ALIASES=("wlan0 ndiswrapper")

ERROR_USB="You need to enable USB support in your kernel
to use usb support in ndiswrapper."

pkg_setup() {
	einfo "See http://www.gentoo.org/doc/en/gentoo-kernel.xml for a list of supported kernels."
	echo  ""
	use usb && CONFIG_CHECK="${CONFIG_CHECK} USB"
	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}
	convert_to_m "${S}/driver/Makefile"
}

src_compile() {
	local params

	# Enable verbose debugging information
	if use debug; then
		params="DEBUG=3"
		use usb && params="${params} USB_DEBUG=1"
	fi

	cd utils
	emake || die "Compile of utils failed!"

	use usb || params="DISABLE_USB=1"

	# Does not like parallel builds
	# http://bugs.gentoo.org/show_bug.cgi?id=154213
	# KBUILD value can't be quoted
	# http://bugs.gentoo.org/show_bug.cgi?id=156319
	BUILD_PARAMS="KSRC=${KV_DIR} KVERS=${KV_FULL} KBUILD=${KV_OUT_DIR} ${params} -j1"
	linux-mod_src_compile
}

src_install() {
	dodoc README INSTALL AUTHORS ChangeLog
	doman ndiswrapper.8

	keepdir /etc/ndiswrapper

	linux-mod_src_install

	cd utils
	emake DESTDIR="${D}" install || die "emake install failed"
}

pkg_postinst() {
	linux-mod_pkg_postinst
	echo
	elog "ndiswrapper requires .inf and .sys files from a Windows(tm) driver"
	elog "to function. Download these to /root for example, then"
	elog "run 'ndiswrapper -i /root/foo.inf'. After that you can delete them."
	elog "They will be copied to the proper location."
	elog "Once done, please run 'update-modules'."
	echo
	elog "check http://ndiswrapper.sf.net/mediawiki/index.php/List for drivers"
	I=$(lspci -n | egrep 'Class (0280|0200):' |  cut -d' ' -f4)
	elog "Look for the following on that page for your driver:"
	elog "Possible Hardware: ${I}"
	echo
	elog "Please have a look at http://ndiswrapper.sourceforge.net/wiki/"
	elog "for the FAQ, HowTos, Tips, Configuration, and installation"
	elog "information."
	echo
	einfo "ndiswrapper devs need support(_hardware_, cash)."
	einfo "Don't hesitate if you can help, see http://ndiswrapper.sf.net for details."
	echo

	einfo "Attempting to automatically reinstall any Windows drivers"
	einfo "you might already have."
	for driver in $(ls /etc/ndiswrapper)
	do
		einfo "Driver: ${driver}"
		mv /etc/ndiswrapper/${driver} ${T}
		ndiswrapper -i ${T}/${driver}/${driver}.inf
	done
}
