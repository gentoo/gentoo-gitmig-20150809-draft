# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-infinity/xmms-infinity-0.5.8.ebuild,v 1.1 2004/07/26 09:05:54 eradicator Exp $

IUSE=""

MY_PN="infinity-plugin"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A psychedelic visualization plug-in for XMMS"
HOMEPAGE="http://infinity-plugin.sourceforge.net"
SRC_URI="mirror://sourceforge/infinity-plugin/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
#-sparc: 0.2: always black - eradicator
KEYWORDS="~x86 ~ppc ~amd64 -sparc"

DEPEND="media-libs/libsdl
	media-sound/xmms"

src_install () {
	make DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS COPYING ChangeLog INSTALL README
}
