# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mcp-plugins/mcp-plugins-0.2.1b.ebuild,v 1.1 2004/01/19 09:01:49 torbenh Exp $
#
MY_P=${P/mcp/MCP}

DESCRIPTION="MCP ladspa plugins package. Includes moogvcf"
HOMEPAGE="http://alsamodular.sourceforge.net/"
SRC_URI="http://alsamodular.sourceforge.net/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="media-libs/ladspa-sdk"

S=${WORKDIR}/${MY_P}

src_compile() {
	make || die
}

src_install() {
	dodoc AUTHORS COPYING README ${S}/ams/*
	insinto /usr/lib/ladspa
	insopts -m0755
	doins *.so
}
