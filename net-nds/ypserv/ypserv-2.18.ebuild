# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nds/ypserv/ypserv-2.18.ebuild,v 1.7 2007/03/26 08:00:03 antarus Exp $

DESCRIPTION="Network Information Service server"
HOMEPAGE="http://www.linux-nis.org/nis/"
SRC_URI="mirror://kernel/linux/utils/net/NIS/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE="slp"

RDEPEND=">=sys-libs/gdbm-1.8.0
	slp? ( net-libs/openslp )"
DEPEND="${RDEPEND}"
RDEPEND="${RDEPEND}
	 net-nds/portmap"

src_compile() {
	econf $(use_enable slp) || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO

	insinto /etc
	doins etc/ypserv.conf etc/netgroup etc/netmasks
	insinto /var/yp
	newins etc/securenets securenets.default

	newconfd ${FILESDIR}/ypserv.confd ypserv
	newconfd ${FILESDIR}/rpc.yppasswdd.confd rpc.yppasswdd
	newconfd ${FILESDIR}/rpc.ypxfrd.confd rpc.ypxfrd

	newinitd ${FILESDIR}/ypserv ypserv
	newinitd ${FILESDIR}/rpc.yppasswdd-r1 rpc.yppasswdd
	newinitd ${FILESDIR}/rpc.ypxfrd rpc.ypxfrd

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
