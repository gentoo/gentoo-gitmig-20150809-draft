# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ltmodem/ltmodem-8.31_alpha8.ebuild,v 1.1 2004/11/06 14:41:32 mrness Exp $

inherit kernel-mod

MY_P="${P/_alpha/a}"
DESCRIPTION="Winmodems with Lucent Apollo (ISA) and Mars (PCI) chipsets"
HOMEPAGE="http://www.heby.de/ltmodem/"
SRC_URI="http://www.physcip.uni-stuttgart.de/heby/ltmodem/${MY_P}.tar.gz
	http://www.sfu.ca/~cth/ltmodem/${MY_P}.tar.gz
	http://linmodems.technion.ac.il/packages/ltmodem/kernel-2.6/ltmodem-2.6-alk-6.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="nouserpriv"

DEPEND="virtual/linux-sources
		sys-apps/util-linux"

S=${WORKDIR}/${MY_P}

src_compile() {
	if kernel-mod_is_2_4_kernel; then
		sed -i -e 's:make -e:make:' -e 's:read -p:echo:' build_module
		FAST="1" ./build_module ${KV} || die "Compilation filed"
	else
		cd ../ltmodem-2.6-alk-6/
		(
			unset ARCH
			addwrite /usr/src/linux-${KV}
			sed -i -e "s:linux-2.6:linux:" Makefile
			make || die "Compilation failed"
		)
	fi
}

src_install() {
	# install docs
	cd DOCs
	dohtml *.html

	rm -rf *.html Installers build* Build* gcc3.txt Examples Suse*
	rm -rf fixscript* slackware srcprep.man scanmodem.man conf*

	rename .man .1 *.man
	doman *.1
	rm -rf *.1

	dodoc ../1ST-READ *
	cd ..

	# install utilities
	mv utils/unloading utils/lt_unloading
	dosbin utils/lt_*

	# install configuration
	insinto /etc/devfs.d
	newins ${FILESDIR}/ltmodem_devfs ltmodem
	insinto /etc/modules.d
	newins ${FILESDIR}/ltmodem_modules ltmodem

	# install kernel module
	if kernel-mod_is_2_4_kernel; then
		cd source
		make install ROOTDIR=${D} || die "Cannot install drivers"
	else
		cd ${WORKDIR}/ltmodem-2.6-alk-6/
		insinto /lib/modules/${KV}/ltmodem
		doins ltmodem.ko &&	doins ltserial.ko || die "Cannot install drivers"
	fi
}

pkg_postinst() {
	[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	depmod -ae ${KV}

	# Make some devices if we aren't using devfs
	if [ -e ${ROOT}/dev/.devfsd ]; then
		ebegin "Restarting devfsd to reread devfs rules"
			killall -HUP devfsd
		eend $?
		einfo "modules-update to complete configuration."

	elif [ -e ${ROOT}/dev/.udev ]; then
		ebegin "Restarting udev to reread udev rules"
			udevstart
		eend $?
	fi

	einfo "Use /dev/tts/LT0 to access modem"
	einfo "If you have problems, read this doc:"
	einfo "/usr/share/doc/${PF}/html/post-install.html"
}
