# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ndiswrapper/ndiswrapper-0.12.ebuild,v 1.1 2004/12/07 19:32:39 cardoe Exp $

inherit kernel-mod

DESCRIPTION="Wrapper for using Windows drivers for some wireless cards"
HOMEPAGE="http://ndiswrapper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE="debug"
DEPEND="sys-apps/pciutils"
S=${WORKDIR}/${PN}-${PV}

src_unpack() {
	check_KV
	kernel-mod_getversion
	unpack ${A}

	# Fix path to kernel and KVERS
	sed -i -e "s:^KSRC.*:KSRC=${ROOT}/usr/src/linux:" \
		-e "s:^KVERS.*:KVERS=${KV_MAJOR}${KV_MINOR}:" \
		${S}/driver/Makefile

	if [ ${KV_MINOR} -gt 5 ] && [ ${KV_PATCH} -gt 5 ]
	then
		sed -i 's:SUBDIRS=:M=:g' ${S}/driver/Makefile
	fi
}

src_compile() {
	# Unset ARCH for 2.5/2.6 kernel compiles
	if [ ${KV_MINOR} -gt 4 ] ; then
		unset ARCH
	fi

	# Enable verbose debugging information
	use debug && export DEBUG=3

	emake || die "Compile Failed!"
}

src_install() {
	if [ ${KV_MINOR} -gt 4 ]
	then
		MOD_SUFFIX="ko"
	else
		MOD_SUFFIX="o"
	fi

	dosbin ${S}/utils/ndiswrapper
	dosbin ${S}/utils/ndiswrapper-buginfo

	dodoc ${S}/README ${S}/INSTALL ${S}/AUTHORS ${S}/ChangeLog
	doman ${S}/ndiswrapper.8

	insinto /lib/modules/${KV}/misc
	doins ${S}/driver/ndiswrapper.${MOD_SUFFIX}

	into /
	dosbin ${S}/utils/loadndisdriver

	insinto /etc/modules.d
	newins ${FILESDIR}/${PN}-0.9-modules.d ndiswrapper

	dodir /etc/ndiswrapper
}

pkg_postinst() {
	echo
	einfo "Checking kernel module dependencies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}
	echo
	einfo "ndiswrapper requires .inf and .sys files from a Windows(tm) driver"
	einfo "to function. Download these to /root for example, then"
	einfo "run 'ndiswrapper -i /root/foo.inf'. After that you can delete them."
	einfo "They will be copied to the proper location."
	einfo "Once done, please run 'update-modules'."
	einfo
	einfo "As of release 0.9, you no longer have to call 'loadndiswrapper'"
	einfo "explicitly.  The module will handle it automatically."
	einfo
	einfo "check http://ndiswrapper.sf.net/supported_chipsets.html for drivers"
	I=`lspci -n | egrep 'Class (0280|0200):' |  cut -d' ' -f4`
	einfo "Look for the following on that page for your driver:"
	einfo ${I}
	einfo
	einfo "Please have a look at http://ndiswrapper.sourceforge.net/wiki/"
	einfo "for the FAQ, HowTos, Tips, Configuration, and installation"
	einfo "information."
	echo
}

pkg_config() {
	ewarn "New versions of ndiswrapper do not require you to run config"

	if [ ! -f "/etc/modules.d/ndiswrapper" ] ; then
		eerror "/etc/modules.d/ndiswrapper not found. Please re-emerge"
		eerror "${PN} to have this file installed, then re-run this script."
		die "Driver configuration file not found!"
	fi
}

