# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bcm570x/bcm570x-7.3.5.ebuild,v 1.1 2004/09/29 20:28:57 kanaka Exp $

MY_P=${P/570x/5700}
SRC_URI="http://www.broadcom.com/docs/driver_download/570x/linux-${PV}.zip"
DESCRIPTION="Driver for the Broadcom 570x-based gigabit cards (found on many mainboards)."
HOMEPAGE="http://www.broadcom.com/docs/driver-sla.php?driver=570x-Linux"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="app-arch/unzip
	virtual/linux-sources"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	tar -xvzpf ${WORKDIR}/Server/Linux/Driver/${MY_P}.tar.gz &> /dev/null ||
		die "could not extract second level archive"
}

src_compile() {
	check_KV

	cd ${S}/src
	if [[ ARCH=x86 ]]; then
		my_arch=i386
	elif [[ ARCH=amd64 ]]; then
		my_arch=x86_64
	fi
	make ARCH=${my_arch} LINUX=/usr/src/linux-${KV} || die "compile failed"
}

src_install() {
	cd ${S}/src
	make ARCH=${my_arch} PREFIX=${D} install || die

	doman bcm5700.4.gz
	cd ${S}
	dodoc DISTRIB.TXT LICENSE README.TXT RELEASE.TXT
}

pkg_postinst() {
	echo ">>> Updating module dependencies..."
	[ -x /sbin/update-modules ] && /sbin/update-modules
	einfo ""
	einfo "${P}.tar.gz also contains a kernel-patch to integrate this driver directly."
	einfo ""
	einfo "To load the module at boot up, add bcm5700 to /etc/modules.autoload.d/KERN_VERSION"
	einfo ""
	einfo "To load the module now without rebooting, use the following command:"
	einfo "modprobe bcm5700"
	einfo ""
	einfo "For more detailed information about this driver:"
	einfo "man 4 bcm5700"
	einfo ""
}
