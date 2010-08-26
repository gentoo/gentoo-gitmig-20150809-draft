# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-mbpurple/pidgin-mbpurple-0.3.0.ebuild,v 1.4 2010/08/26 11:22:24 hwoarang Exp $

EAPI=2

inherit base toolchain-funcs

DESCRIPTION="Libpurple (Pidgin) plug-in supporting microblog services like Twitter or identi.ca"
HOMEPAGE="http://code.google.com/p/microblog-purple/"
MY_P="${P/pidgin-/}"
SRC_URI="http://microblog-purple.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="net-im/pidgin[gtk]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
S=${WORKDIR}/${MY_P}

pkg_setup() {
	tc-export CC
}

src_prepare() {
	sed -i "/^LDFLAGS/d" global.mak || die
}
