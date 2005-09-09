# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-idcin/xmms-idcin-0.5.ebuild,v 1.11 2005/09/09 12:02:08 flameeyes Exp $

MY_PN=${PN/-/_}
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}

HOMEPAGE="http://havardk.xmms.org/plugins/idcin/"
DESCRIPTION="play Quake II cinematic files in XMMS"
SRC_URI="http://havardk.xmms.org/plugins/idcin/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc -sparc x86"
IUSE=""

DEPEND=">=media-sound/xmms-1.2.7-r20"

src_install() {
	make DESTDIR="${D}" libdir=`xmms-config --input-plugin-dir` install || die
	dodoc AUTHORS NEWS ChangeLog
}
