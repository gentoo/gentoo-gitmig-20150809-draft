# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/dynfw/dynfw-1.0.1.ebuild,v 1.2 2003/03/04 00:56:29 vladimir Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Dynamic Firewall Tools for netfilter-based firewalls"
SRC_URI="http://gentoo.org/projects/${P}.tar.gz"
HOMEPAGE="http://gentoo.org/projects/dynfw"
DEPEND="sys-apps/bash"
KEYWORDS="x86 sparc "
SLOT="0"
LICENSE="GPL-2"

src_install () {
	dodir /usr/sbin
	dodir /usr/share

	local PREFIX
	PREFIX="/usr"

	for x in ipblock ipdrop tcplimit host-tcplimit user-outblock
	do
		einfo Setting PREFIX in: ${x}
		sed -e "s:##PREFIX##:${PREFIX}:g" < ${x} > ${D}/usr/sbin/${x}
		chown 0.0 ${D}/usr/sbin/${x}
		chmod 0755 ${D}/usr/sbin/${x}
	done
	install -m0755 dynfw.sh ${D}/usr/share
}
