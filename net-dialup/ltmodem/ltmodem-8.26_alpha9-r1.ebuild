# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/ltmodem/ltmodem-8.26_alpha9-r1.ebuild,v 1.10 2004/07/14 22:56:16 agriffis Exp $

MY_P="${P/_alpha/a}"
DESCRIPTION="Winmodems with Lucent Apollo (ISA) and Mars (PCI) chipsets"
HOMEPAGE="http://www.heby.de/ltmodem/"
SRC_URI="http://www.physcip.uni-stuttgart.de/heby/ltmodem/${MY_P}.tar.gz
	http://www.sfu.ca/~cth/ltmodem/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/linux-sources"

S=${WORKDIR}/${MY_P}

src_compile() {
	cp build_module{,.orig}
	sed -e 's:make -e:make:' \
	 -e 's:read -p:echo:' \
		build_module.orig > build_module
	FAST="1" ./build_module || die
}

src_install() {
	dohtml DOCs/*.html
	rm -rf DOCs/*.html DOCs/Installers

	dodoc 1ST-READ BLDrecord.txt Utility_version_tests.txt DOCs/*

	mv utils/fixscript utils/ltfixscript
	mv utils/noisefix utils/ltnoisefix
	mv utils/unloading utils/ltunloading
	dobin utils/lt*

	cd source
	make install ROOTDIR=${D} || die

	insinto /etc/devfs.d
	newins debian/etc_devfs_conf.d_ltmodem ltmodem
	insinto /etc/modules.d
	newins debian/modules ltmodem
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
