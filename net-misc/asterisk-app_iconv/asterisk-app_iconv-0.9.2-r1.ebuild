# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_iconv/asterisk-app_iconv-0.9.2-r1.ebuild,v 1.2 2007/03/12 20:25:03 opfer Exp $

inherit eutils toolchain-funcs

MY_P="${P/asterisk-}"

DESCRIPTION="Asterisk application plugin for character conversion"
HOMEPAGE="http://www.mezzo.net/asterisk/"
SRC_URI="http://www.mezzo.net/asterisk/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"

DEPEND="sys-libs/glibc
	>=net-misc/asterisk-1.0.5-r2"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# patch makefile
	sed -i -e "s:^\(CFLAGS\)=:\1+=:g" \
		-e "s:\(RES=\).*echo \"\(.*\)\".*:\1\2:g" \
		-e "s:\(\$(SOLINK)\):\$(LDFLAGS) \1:g" Makefile
}

src_compile() {
	emake CC=$(tc-getCC) || die "emake failed"
}

src_install() {
	exeinto /usr/$(get_libdir)/asterisk/modules
	doexe app_iconv.so
	dodoc CHANGES README
}
