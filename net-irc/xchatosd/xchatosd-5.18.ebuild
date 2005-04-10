# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchatosd/xchatosd-5.18.ebuild,v 1.3 2005/04/10 11:48:36 swegener Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="On-Screen Display for XChat"
HOMEPAGE="http://sourceforge.net/projects/xchatosd/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64 ~ia64"
IUSE="iconv"

RDEPEND=">=x11-libs/xosd-2.2.5
	>=net-irc/xchat-2.0.9"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	# We have our own include file in /usr/include/xchat
	einfo "Updating xchat-plugin.h from /usr/include/xchat/xchat-plugin.h"
	cp -f ${ROOT}/usr/include/xchat/xchat-plugin.h xchat-plugin.h
}

src_compile() {
	append-flags -fPIC -DPIC
	use iconv || sed -i -e "/^#define ICONV_LIB$/d" xchatosd.h

	emake CC="$(tc-getCXX)" CPP="$(tc-getCXX)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/xchat/plugins
	doexe xchatosd.so || die "doexe failed"
	dodoc ChangeLog README || die "dodoc failed"
}
