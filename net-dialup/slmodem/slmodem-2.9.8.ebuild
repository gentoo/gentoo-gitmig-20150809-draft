# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/slmodem/slmodem-2.9.8.ebuild,v 1.4 2004/07/14 23:10:35 agriffis Exp $

inherit kmod eutils

DESCRIPTION="Driver for Smart Link modem"
HOMEPAGE="http://www.smlink.com/"
SRC_URI="ftp://ftp.smlink.com/linux/unsupported/${P}.tar.gz"
LICENSE="Smart-Link"
SLOT="0"
KEYWORDS="-*"
IUSE="alsa"

DEPEND="virtual/libc
	alsa? ( media-libs/alsa-lib )
	sys-kernel/config-kernel"

RDEPEND="${DEPEND}"

KMOD_SOURCES="${P}.tar.gz"

src_unpack() {
	kmod_src_unpack
	cd ${S}
	epatch ${FILESDIR}/${P}-makefile-fixup.patch
	epatch ${FILESDIR}/${P}-udev.patch
}

src_compile() {

	[ -d /lib/modules/${KERNEL_VER/linux-/}/build ] || die "Build kernel ${KERNEL_VER} first"

	unset ARCH


	mkdir ${S}/workdir

	emake MODVERDIR=${T}/.tmp_versions O=${S}/workdir \
		KERNEL_VER=${KERNEL_VER/linux-/} \
		drivers || die "Failed to compile driver"

	cd modem;
	if use alsa;
	then
		emake SUPPORT_ALSA=1 MODVERDIR=${T}/.tmp_versions O=${S}/workdir \
			KERNEL_VER=${KERNEL_VER/linux-/} \
			|| die 'Alsa support failed, try USE="-alsa"'
	else
		emake MODVERDIR=${T}/.tmp_versions O=${S}/workdir \
			KERNEL_VER=${KERNEL_VER/linux-/} \
			 || die "Could not compile"
	fi
}

src_test() {
	cd modem
	emake modem_test
	./modem_test || die "failed modem test"

}

src_install() {
	unset ARCH
	emake DESTDIR=${D} KERNEL_VER=${KERNEL_VER/linux-/} install-drivers \
		|| die "driver install failed"

	dosbin modem/slmodemd
	dodir /var/lib/slmodem
	fowners root:dialout /var/lib/slmodem

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
		# FIX Symlink
		dodir /etc/udev/rules.d/
		echo 'KERNEL="slamr", NAME="slamr0", SYMLINK="modem"' > \
			 ${D}/etc/udev/rules.d/55-${PN}.rules
		dodir /etc/udev/permissions.d
		echo 'slamr*:root:dialout:0660' > \
			${D}/etc/udev/permissions.d/55-${PN}.permissions
	else
	# simple raw devs
		dodir /dev
		cd ${D}/dev
		ebegin "Creating /dev/slamr* devices"
		local C="0"
		while [ "${C}" -lt "4" ]
		do
			if [ ! -c ${ROOT}/dev/slamr${C} ]
			then
				mknod ${D}/dev/slamr${C} c 212 ${C}
			#	doco suggests that the slmodemd creates these
			#	ln -s slamr${C} ttySL${C}
			fi
			if [ ! -c ${ROOT}/dev/slamr${C} ]
			then
				mknod ${D}/dev/slusb${C} c 213 ${C}
			#TODO usb or slamr (AMR/CNR/PCI) version for symlinks???
			#	ln -s sl${C} ttySL${C}
			fi

			C="`expr $C + 1`"
		done
		eend 0
		ln -s ttySL0 modem
	fi

}

pkg_postinst() {
	kmod_pkg_postinst

	#depmod -a

	# Make some devices if we aren't using devfs
	# If we are using devfs, restart it
	if [ -e ${ROOT}/dev/.devfsd ]
	then
		ebegin "Restarting devfsd to reread devfs rules"
			killall -HUP devfsd
		eend 0
		einfo "modules-update to complete configuration."

	elif [ -e ${ROOT}/dev/.udev ]
	then
		ebegin "Restarting udev to reread udev rules"
			udevstart
		eend 0
	fi

	echo

	einfo "You must edit /etc/conf.d/${PN} for your configuration"

	if use alsa;
	then
		einfo
		einfo "If you need to use snd-intel8x0m from the kernel"
		einfo "compile it as a module and edit /etc/module.d/alsa"
		einfo 'to: "alias snd-card-(number) snd-intel8x0m"'
	fi
}
