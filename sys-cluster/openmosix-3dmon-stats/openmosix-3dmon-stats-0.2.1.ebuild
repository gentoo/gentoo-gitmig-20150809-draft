# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openmosix-3dmon-stats/openmosix-3dmon-stats-0.2.1.ebuild,v 1.1 2004/03/21 19:49:31 tantive Exp $

S=${WORKDIR}/mosstatd-${PV}
DESCRIPTION="Statistics daemon for three dimensional openmosix's monitoring tool"
SRC_URI="mirror://sourceforge/threedmosmon/mosstatd-${PV}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/threedmosmon"
DEPEND="virtual/glibc
	sys-cluster/openmosix-user"
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~x86"

pkg_setup() {
	if [ -z "`readlink /usr/src/linux|grep openmosix`" ]; then
		eerror
		eerror "Your linux kernel sources do not appear to be openmosix,"
		eerror "please check your /usr/src/linux symlink."
		eerror
		die
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-makefile+init-script.patch.bz2 \
		|| die "Failed to patch the source."
}

src_compile() {
	cd ${S}
	make
}

src_install() {
	dodir /usr/sbin
	dodir /etc/init.d
	dodir /usr/share/doc

	cd ${S}
	chmod 0755 mosstatd && cp -f ./mosstatd ${D}/usr/sbin
	chmod 0750 mosstat && cp -f ./mosstat ${D}/etc/init.d/mosstat

	cd ${S}
	dodoc README ChangeLog
}

pkg_postinst() {
	einfo
	einfo " Type:"
	einfo " # rc-update add mosstat default"
	einfo " to add openMosix to the default runlevel."
	einfo
}
