# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/ypserv/ypserv-2.13-r1.ebuild,v 1.4 2004/07/24 06:26:28 eradicator Exp $

DESCRIPTION="Network Information Service server"
HOMEPAGE="http://www.linux-nis.org/nis/"
SRC_URI="mirror://kernel/linux/utils/net/NIS/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~ppc64 amd64"
IUSE=""

DEPEND=">=sys-libs/gdbm-1.8.0"

src_install() {
	make DESTDIR=${D} install
	dodoc AUTHORS ChangeLog INSTALL NEWS README THANKS TODO

	insinto /etc
	doins etc/ypserv.conf etc/netgroup etc/netmasks

	insinto /var/yp
	newins etc/securenets securenets.default

	insinto /etc/conf.d
	newins ${FILESDIR}/ypserv.confd ypserv
	newins ${FILESDIR}/rpc.yppasswdd.confd rpc.yppasswdd
	newins ${FILESDIR}/rpc.ypxfrd.confd rpc.ypxfrd

	exeinto /etc/init.d
	newexe ${FILESDIR}/ypserv ypserv
	newexe ${FILESDIR}/rpc.yppasswdd-r1 rpc.yppasswdd
	newexe ${FILESDIR}/rpc.ypxfrd rpc.ypxfrd

	# Save the old config into the new package as CONFIG_PROTECT
	# doesn't work for this package.
	if [ -f ${ROOT}/var/yp/Makefile ]; then
		mv ${D}/var/yp/Makefile ${D}/var/yp/Makefile.dist
		cp ${ROOT}/var/yp/Makefile ${D}/var/yp/Makefile
		einfo "As you have a previous /var/yp/Makefile, I have added"
		einfo "this file into the new package and installed the new"
		einfo "file as /var/yp/Makefile.dist"
	fi
}

pkg_postinst() {
	einfo "To complete setup, you will need to edit /var/yp/securenets,"
	einfo "/etc/conf.d/ypserv, /etc/ypserv.conf, /etc/conf.d/rpc.yppasswdd"
	einfo "and possibly /var/yp/Makefile."

	einfo "To start the services at boot, you need to enable ypserv and optionally"
	einfo "the rpc.yppasswdd and/or rpc.ypxfrd services"
}
