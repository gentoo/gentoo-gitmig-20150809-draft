# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/mwavem/mwavem-2.0.ebuild,v 1.9 2008/05/19 19:52:43 mrness Exp $

DESCRIPTION="User level application for IBM Mwave modem"
HOMEPAGE="http://oss.software.ibm.com/acpmodem/"
SRC_URI="ftp://www-126.ibm.com/pub/acpmodem/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

src_compile() {
	#Disable installing stuff outside sandbox
	sed -i -e 's/^install-exec-local:.*$/&\n\ninstall-exec-local-invalid:/' \
		src/mwavem/Makefile.am src/mwavem/Makefile.in

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	exeinto /usr/sbin
	doexe "${FILESDIR}/mwave-dev-handler"

	insinto /etc/devfs.d
	newins "${FILESDIR}/mwave.devfs" mwave

	insinto /etc/modprobe.d
	newins "${FILESDIR}/mwave.modules" mwave

	dodoc AUTHORS ChangeLog FAQ NEWS README README.devfs THANKS
	docinto doc
	dodoc doc/mwave.sgml doc/mwave.txt
	dohtml doc/mwave.html
}

pkg_postinst() {
	# Below is to get /etc/modules.d/mwave loaded into /etc/modules.conf
	if [ "$ROOT" = "/" ]; then
		[ -x /sbin/update-modules ] && /sbin/update-modules || /sbin/modules-update
	fi

	if [ -e "${ROOT}/dev/.devfsd" ]; then
		# device node is created by devfs
		ebegin "Restarting devfsd to reread devfs rules"
			killall -HUP devfsd
		eend $?
	elif [ -e "${ROOT}/dev/.udev" ]; then
		#the device should be created by udev
		ebegin "Restarting udev to reread udev rules"
			udevcontrol reload_rules
		eend $?
	else
		[ ! -d "${ROOT}/dev/modem" ] && mkdir --mode=0755 "${ROOT}/dev/modems"
		mknod --mode=0660 "${ROOT}/dev/modems/mwave" c 10 219
	fi
}
