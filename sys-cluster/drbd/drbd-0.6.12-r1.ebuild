# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/drbd/drbd-0.6.12-r1.ebuild,v 1.2 2004/08/31 02:55:46 mr_bones_ Exp $

inherit eutils

LICENSE="GPL-2"
KEYWORDS="~x86"

DESCRIPTION="mirror/replicate block-devices across a network-connection"
#SRC_URI="http://www.linbit.com/en/filemanager/download/44/drbd-${PV}.tar.gz"
SRC_URI="http://www.drbd.org/uploads/media/drbd-${PV}.tar.gz"
HOMEPAGE="http://www.drbd.org"

IUSE=""

DEPEND="virtual/linux-sources"
RDEPEND=">=sys-cluster/heartbeat-1.0*"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-Makefile.vars.patch
	cd drbd
	epatch ${FILESDIR}/${PV}-module-Makefile.patch
	cd ..
	cd scripts
	epatch ${FILESDIR}/${PV}-scripts-Makefile.patch
	cd ${S}
}

src_compile() {
	check_KV
	einfo ""
	einfo "Your kernel-sources in /usr/src/linux-${KV} must be properly configured"
	einfo "and match the currently running kernel version ${KV}"
	einfo "If otherwise -> build will fail."
	einfo ""
	cd ${S}
	cp -R /usr/src/linux-${KV} ${WORKDIR}
	emake KDIR=/${WORKDIR}/linux-${KV} || die
}

src_install() {
	cd ${S}
	make PREFIX=${D} install

	# gentoo-ish init-script
	dodir /etc
	dodir /etc/init.d
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PV}-init drbd || die

	# config
	dodir /etc/conf.d
	insinto /etc/conf.d
	doins ${FILESDIR}/${PV}-conf.d || die

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
