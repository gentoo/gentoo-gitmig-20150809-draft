# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ndiswrapper/ndiswrapper-1.2.ebuild,v 1.2 2005/06/30 22:13:26 cardoe Exp $

inherit linux-mod eutils

DESCRIPTION="Wrapper for using Windows drivers for some wireless cards"
HOMEPAGE="http://ndiswrapper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

IUSE="debug"
DEPEND="sys-apps/pciutils"
RDEPEND="${DEPEND}
	net-wireless/wireless-tools"

S=${WORKDIR}/${P}

CONFIG_CHECK="NET_RADIO"

MODULE_NAMES="ndiswrapper(misc:${S}/driver)"
BUILD_PARAMS="KSRC=${ROOT}${KV_DIR} KVERS=${KV_MAJOR}${KV_MINOR}"
BUILD_TARGETS="all"
MODULESD_NDISWRAPPER_ALIASES=("wlan0 ndiswrapper")

src_unpack() {
	unpack ${A}

	if grep '# CONFIG_SOFTWARE_SUSPEND2 is not set' ${ROOT}${KV_DIR}/.config
	then
		eerror "You have a kernel patched with Software Suspend 2 (swsusp2)"
		eerror "but don't have it enabled. You must remove the patch or"
		eerror "enable Software Suspend 2 (swsusp2)."
		eerror "http://bugs.gentoo.org/show_bug.cgi?id=74864"
		die "Please fix your kernel"
	fi

	epatch ${FILESDIR}/${P}-swsusp2.patch || die "swsusp2 patch failed"

	convert_to_m ${S}/driver/Makefile
}

src_compile() {
	# Enable verbose debugging information
	use debug && export DEBUG=3

	cd utils
	emake || die "Compile of utils failed!"

	linux-mod_src_compile

}

src_install() {
	dosbin utils/ndiswrapper
	dosbin utils/ndiswrapper-buginfo

	into /
	dosbin utils/loadndisdriver

	dodoc README INSTALL AUTHORS ChangeLog
	doman ndiswrapper.8

	keepdir /etc/ndiswrapper

	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
	echo
	einfo "ndiswrapper requires .inf and .sys files from a Windows(tm) driver"
	einfo "to function. Download these to /root for example, then"
	einfo "run 'ndiswrapper -i /root/foo.inf'. After that you can delete them."
	einfo "They will be copied to the proper location."
	einfo "Once done, please run 'update-modules'."
	echo
	einfo "check http://ndiswrapper.sf.net/phpwiki/index.php/List for drivers"
	I=$(lspci -n | egrep 'Class (0280|0200):' |  cut -d' ' -f4)
	einfo "Look for the following on that page for your driver:"
	einfo "Possible Hardware: ${I}"
	echo
	einfo "Please have a look at http://ndiswrapper.sourceforge.net/wiki/"
	einfo "for the FAQ, HowTos, Tips, Configuration, and installation"
	einfo "information."
	echo
	ewarn "Attempting to automatically reinstall any Windows drivers"
	ewarn "you might already have."
	for driver in $(ls /etc/ndiswrapper)
	do
		einfo "Driver: ${driver}"
		mv /etc/ndiswrapper/${driver} /tmp
		ndiswrapper -i /tmp/${driver}/${driver}.inf
	done
}
