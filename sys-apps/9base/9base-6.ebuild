# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/9base/9base-6.ebuild,v 1.1 2010/06/11 16:24:26 ssuominen Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="A port of various original Plan 9 tools for Unix, based on plan9port"
HOMEPAGE="http://tools.suckless.org/9base"
SRC_URI="http://dl.suckless.org/tools/${P}.tar.gz"

LICENSE="9base"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {
	export PORTAGE_COMPRESS=

	local _objtype=386
	[[ $(tc-arch) == "amd64" ]] && _objtype=x86_64

	my9baseopts=(
		"PREFIX=/usr/plan9"
		"OBJTYPE=${_objtype}"
		"AR=$(tc-getAR) rc"
		"CC=$(tc-getCC)"
		"DESTDIR=${D}"
		)
}

src_prepare() {
	sed -i -e '/strip/d' std.mk {diff,sam}/Makefile || die
}

src_compile() {
	emake "${my9baseopts[@]}" || die
}

src_install() {
	emake "${my9baseopts[@]}" install || die
	dodoc README
}
