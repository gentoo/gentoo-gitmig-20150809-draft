# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mcp-plugins/mcp-plugins-0.3.0.ebuild,v 1.4 2004/07/26 07:40:50 eradicator Exp $

IUSE=""
#
MY_P=${P/mcp/MCP}

DESCRIPTION="MCP ladspa plugins package. Includes moogvcf, phaser & chorus"
HOMEPAGE="http://users.skynet.be/solaris/linuxaudio/"
SRC_URI="http://users.skynet.be/solaris/linuxaudio/downloads/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"

DEPEND="media-libs/ladspa-sdk"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake || die
}

src_install() {
	dodoc AUTHORS COPYING README
	insinto /usr/lib/ladspa
	insopts -m0755
	doins *.so
}
