# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/drbd/drbd-0.6.6-r2.ebuild,v 1.2 2003/09/11 01:29:22 msterret Exp $

LICENSE="GPL-2"
KEYWORDS="x86"

DESCRIPTION="mirror/replicate block-devices across a network-connection"
SRC_URI="http://www.linbit.com/en/filemanager/download/44/drbd-${PV}.tar.gz"
HOMEPAGE="http://www.drbd.org"

IUSE=""

DEPEND="=sys-kernel/vanilla-sources-2.4*"
RDEPEND="=sys-cluster/heartbeat-1.0*"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/0.6.6-Makefile.vars.patch
	epatch ${FILESDIR}/0.6.6-drbd-Makefile.patch
	epatch ${FILESDIR}/0.6.6-scripts-Makefile.patch
}

src_compile() {
	check_KV
	einfo ""
	einfo "Your kernel-sources in /usr/src/linux-${KV} must be properly configured"
	einfo "and match the currently running kernel version ${KV}"
	einfo "If otherwise -> build will fail."
	einfo ""
	cd ${S}
	emake || die
}

src_install() {
	cd ${S}
	make PREFIX=${D} install

	# gentoo-ish init-script
	dodir /etc
	dodir /etc/init.d
	exeinto /etc/init.d
	newexe ${FILESDIR}/0.6.6-init drbd

	# needed by drbd startup script
	dodir /var/lib/drbd
	keepdir /var/lib/drbd

	# docs
	dodoc README ChangeLog COPYING
	dodoc documentation/NFS-Server-README.txt
	# we put drbd.conf into docs
	# it doesnt make sense to install a default conf in /etc
	# put it to the docs
	dodoc scripts/drbd.conf
}

pkg_postinst() {
	einfo ""
	einfo "upgrading module dependencies ... "
	/sbin/depmod -a -F /lib/modules/${KV}/build/System.map
	einfo "... done"
	einfo ""
	einfo "Please remember to re-emerge drbd when you upgrade your kernel!"
	einfo ""
	einfo "Please copy and gunzip the configuration file"
	einfo "from /usr/share/doc/${PF}/drbd.conf.gz to /etc"
	einfo "and edit it to your needs. Helpful commands:"
	einfo "man 5 drbd.conf"
	einfo "man 8 drbdsetup"
	einfo ""
}
