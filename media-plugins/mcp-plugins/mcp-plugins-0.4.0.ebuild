# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mcp-plugins/mcp-plugins-0.4.0.ebuild,v 1.1 2008/04/19 14:12:19 aballier Exp $

inherit multilib toolchain-funcs

IUSE=""

MY_P=${P/mcp/MCP}

DESCRIPTION="MCP ladspa plugins package. Includes moogvcf, phaser & chorus"
HOMEPAGE="http://www.kokkinizita.net/linuxaudio/"
SRC_URI="http://www.kokkinizita.net/linuxaudio/downloads/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="media-libs/ladspa-sdk"

S=${WORKDIR}/${MY_P}

src_compile() {
	tc-export CXX
	sed -i -e "s/-O3//" Makefile
	sed -i -e "s/g++/$(tc-getCXX)/" Makefile
	emake || die
}

src_install() {
	dodoc AUTHORS README
	insinto /usr/$(get_libdir)/ladspa
	insopts -m0755
	doins *.so
}
