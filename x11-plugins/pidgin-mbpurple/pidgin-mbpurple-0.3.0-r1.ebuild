# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-mbpurple/pidgin-mbpurple-0.3.0-r1.ebuild,v 1.1 2011/01/13 08:46:16 fauli Exp $

EAPI=2

inherit base toolchain-funcs

DESCRIPTION="Libpurple (Pidgin) plug-in supporting microblog services like Twitter or identi.ca"
HOMEPAGE="http://code.google.com/p/microblog-purple/"
MY_P="${P/pidgin-/}"
SRC_URI="http://microblog-purple.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+twitgin"

RDEPEND="net-im/pidgin
	twitgin? ( net-im/pidgin[gtk] )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
S=${WORKDIR}/${MY_P}

pkg_setup() {
	tc-export CC
}

src_prepare() {
	sed -i "/^LDFLAGS/d" global.mak || die
	if ! use twitgin; then
		sed -i 's/twitgin//g' Makefile || die
	fi
}
