# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/slmodem/slmodem-2.9.7-r1.ebuild,v 1.3 2004/06/05 12:11:00 dragonheart Exp $

inherit eutils

DESCRIPTION="Driver for Smart Link modem"
HOMEPAGE="http://www.smlink.com/"
MY_P="${P}"
SRC_URI="ftp://ftp.smlink.com/linux/unsupported/${MY_P}.tar.gz"
LICENSE="Smart-Link"
SLOT="0"
KEYWORDS="~x86"
IUSE="alsa"
RDEPEND="virtual/glibc"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-makefile-fixup.patch
}

src_compile() {
	if has sandbox ${FEATURES} || has userpriv ${FEATURES} || has usersandbox ${FEATURES}; then
		ewarn "Users emerging this with a 2.6 kernel still need to disable"
		ewarn "sandbox, usersandbox, userpriv from FEATURES."
		einfo 'use: env FEATURES="-userpriv -usersandbox -sandbox" emerge slmodem'
		die "bad FEATURES - sandbox, usersandbox and/or userpriv "
	fi
	unset ARCH
	if use alsa ; then
		emake SUPPORT_ALSA=1 MODVERDIR=${T}/.tmp_versions || die 'Alsa support failed, try USE="-alsa"'
	else
		emake || die "Could not compile"
	fi
}

src_install() {
	unset ARCH
	emake DESTDIR=${D} install || die

	dodoc COPYING Changes README README.1st

	# Install /etc/{devfs,modules,init,conf}.d/slmodem files
	insinto /etc/conf.d/; newins ${FILESDIR}/${PN}-2.9.conf ${PN}
	insopts -m0755; insinto /etc/init.d/; newins ${FILESDIR}/${PN}-2.9.init ${PN}

	# Make some devices if we aren't using devfs
	# If we are using devfs, restart it
	if [ -e ${ROOT}/dev/.devfsd ] ; then
	# devfs
		insinto /etc/devfs.d/; newins ${FILESDIR}/${PN}-2.9.devfs ${PN}
		insinto /etc/modules.d/; newins ${FILESDIR}/${PN}-2.9.modules ${PN}
	elif [ -e ${ROOT}/dev/.udev ] ; then
	# udev
		dodir /etc/udev/rules.d/
		echo 'KERNEL="slamr", NAME="slamr0", SYMLINK="modem"' > \
			 ${D}/etc/udev/rules.d/55-${PN}.rules
		dodir /etc/udev/permissions.d
		echo 'slamr*:root:dialout:0660' > \
			${D}/etc/udev/permissions.d/55-${PN}.permissions
	else
	# simple raw devs
		dodir /dev
		ebegin "Creating /dev/slamr* devices"
		local C="0"
		while [ "${C}" -lt "4" ]
		do
			if [ ! -c ${ROOT}/dev/slamr${C} ]
			then
				mknod ${D}/dev/slamr${C} c 212 0
			fi
			C="`expr $C + 1`"
		done
		eend 0
	fi

}

pkg_postinst() {
	depmod -a
	# Make some devices if we aren't using devfs
	# If we are using devfs, restart it
	if [ -e ${ROOT}/dev/.devfsd ]
	then

		ebegin "Restarting devfsd to create /dev/modem symlink"
			killall -HUP devfsd
		eend 0
		einfo "modules-update to complete configuration."

	elif [ -e ${ROOT}/dev/.udev ]
	then
		ebegin "Restarting udevd to create /dev/modem symlink"
			killall -HUP udevd &>/dev/null
		eend 0
	fi

	echo
	einfo "You must edit /etc/conf.d/${PN} for your configuration"
}
