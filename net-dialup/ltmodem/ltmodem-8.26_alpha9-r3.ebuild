# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ltmodem/ltmodem-8.26_alpha9-r3.ebuild,v 1.5 2004/11/19 22:31:03 mrness Exp $

inherit kernel-mod

MY_P="${P/_alpha/a}"
DESCRIPTION="Winmodems with Lucent Apollo (ISA) and Mars (PCI) chipsets"
HOMEPAGE="http://www.heby.de/ltmodem/"
SRC_URI="http://www.physcip.uni-stuttgart.de/heby/ltmodem/${MY_P}.tar.gz
	http://www.sfu.ca/~cth/ltmodem/${MY_P}.tar.gz
	http://linmodems.technion.ac.il/packages/ltmodem/kernel-2.6/ltmodem-2.6-alk-v00.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RESTRICT="nouserpriv"

DEPEND="virtual/linux-sources
	app-shells/bash"

S=${WORKDIR}/${MY_P}

src_compile() {
	if kernel-mod_is_2_4_kernel; then
		sed -i -e 's:make -e:make:' -e 's:read -p:echo:' build_module
		FAST="1" ./build_module || die
	else
		cd ../ltmodem-2.6-alk/
		unset ARCH
		addwrite /usr/src/linux-${KV}
		sed -i -e "s:linux-2.6:linux:" Makefile
		make || die
	fi
}

src_install() {
	# install docs
	cd DOCs
	dohtml *.html

	rm -rf *.html Installers build* Build* gcc3.txt Examples Suse*
	rm -rf fixscript* slackware srcprep.man scanmodem.man conf*

	for i in *.man; do mv ${i} ${i}.1; done
	doman *.man.1
	rm -rf *.man.1

	dodoc ../1ST-READ *
	cd ..

	# install utilities
	mv utils/unloading utils/lt_unloading
	dosbin utils/lt_*

	# install configuration
	if kernel-mod_is_2_6_kernel; then
		tar -xzf source.tar.gz
		sed -e "s:@LT_SERIAL_MODULE@:ltmodem:" source/debian/modules.in > source/debian/modules
	fi
	cd source

	insinto /etc/devfs.d
	newins debian/etc_devfs_conf.d_ltmodem ltmodem
	insinto /etc/modules.d
	newins debian/modules ltmodem

	# install kernel module
	if kernel-mod_is_2_4_kernel; then
		make install ROOTDIR=${D} || die
	else
		cd ${WORKDIR}/ltmodem-2.6-alk/
		insinto /lib/modules/${KV}/ltmodem
		doins ltmodem.ko
		doins ltserial.ko
	fi
}

pkg_postinst() {
	[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	einfo "Use /dev/modem to access modem"
	einfo "If you have problems, read this doc:"
	einfo "/usr/share/doc/${PF}/html/post-install.html"
	echo
	einfo "Also, if you wish to access the modem through"
	einfo "/dev/modem without rebooting, run this:"
	einfo "killall -HUP devfsd"
}
