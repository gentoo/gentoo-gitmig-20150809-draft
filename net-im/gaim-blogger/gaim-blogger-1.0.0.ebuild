# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim-blogger/gaim-blogger-1.0.0.ebuild,v 1.3 2005/03/22 10:20:05 eradicator Exp $

inherit multilib toolchain-funcs

DESCRIPTION="Gaim-blogger is a protocol plugin for Gaim which makes use of Gaim's IM interface to post, edit, view and track blogs."
HOMEPAGE="http://gaim-blogger.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ~ppc"
IUSE=""
DEPEND=">=net-im/gaim-1.0.0"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:PREFIX = /usr/local:PREFIX = /usr:g' \
	       -e 's:GAIM_TOP = ../gaim:GAIM_TOP = /usr/include/gaim:g' Makefile

	[[ $(get_libdir) == "lib" ]] || sed -i -e "s:/lib/:/$(get_libdir)/:g" Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	exeinto /usr/$(get_libdir)/gaim
	doexe libblogger.so

	insinto /usr/share/pixmaps/gaim/status/default
	doins pixmaps/blogger.png

	dodoc COPYING ChangeLog
}
