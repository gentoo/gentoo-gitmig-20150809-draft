# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-idcin/xmms-idcin-0.5.ebuild,v 1.4 2004/03/29 23:25:12 dholm Exp $

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Xmms_idcin is a plugin for XMMS which plays an Id Software Quake II cinematic file."
SRC_URI="http://havardk.xmms.org/plugins/idcin/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"

IUSE=""

DEPEND=">=media-sound/xmms-1.2.7-r20"

src_install() {
	make DESTDIR=${D} libdir=/usr/lib/xmms/Input install || die
	dodoc AUTHORS COPYING NEWS ChangeLog INSTALL
}
