# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/ndiswrapper/ndiswrapper-0.9.ebuild,v 1.1 2004/08/16 14:34:21 cardoe Exp $

inherit kernel-mod

MY_P=${PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Wrapper for using Windows drivers for some wireless cards"
HOMEPAGE="http://ndiswrapper.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

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
	unset ARCH
	emake || die
}

src_install() {
	if [ ${KV_MINOR} -gt 4 ]
	then
		KV_OBJ="ko"
	else
		KV_OBJ="o"
	fi

	dosbin ${S}/utils/ndiswrapper
	dosbin ${S}/utils/wlan_radio_averatec_5110hx

	dodoc ${S}/README ${S}/INSTALL ${S}/AUTHORS ${S}/ChangeLog

	insinto /lib/modules/${KV}/misc
	doins ${S}/driver/ndiswrapper.${KV_OBJ}

	into /
	dosbin ${S}/utils/loadndisdriver

	insinto /etc/modules.d
	newins ${FILESDIR}/${PN}-0.9-modules.d ndiswrapper

	dodir /etc/ndiswrapper
}

pkg_postinst() {
	einfo "Checking kernel module dependancies"
	test -r "${ROOT}/usr/src/linux/System.map" && \
		depmod -ae -F "${ROOT}/usr/src/linux/System.map" -b "${ROOT}" -r ${KV}


	einfo
	einfo "ndiswrapper requires .inf and .sys files from a Windows(tm) driver"
	einfo "to function. Put these somewhere like /usr/local/lib/ndis,"
	einfo "run 'ndiswrapper -i /usr/local/ndis/foo.inf'."
	einfo "One done, please run 'update-modules'."
	einfo
	einfo "As of release 0.9, you no longer have to call 'loadndiswrapper'"
	einfo "explicitly.  The module will handle it automatically."
	einfo
}

pkg_config() {
	ewarn "New versions of ndiswrapper do not require you to run config"

	if [ ! -f "/etc/modules.d/ndiswrapper" ]
	then
		eerror "/etc/modules.d/ndiswrapper not found. Please re-emerge"
		eerror "${PN} to have this file installed, then re-run this script"
		die "Driver configuration file not found"
	fi
}

