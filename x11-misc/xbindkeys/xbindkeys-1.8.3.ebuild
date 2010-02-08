# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xbindkeys/xbindkeys-1.8.3.ebuild,v 1.1 2010/02/08 18:11:28 jer Exp $

inherit eutils

IUSE="guile tk"

DESCRIPTION="Tool for launching commands on keystrokes"
SRC_URI="http://www.nongnu.org/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/xbindkeys/xbindkeys.html"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"

RDEPEND="x11-libs/libX11
	guile? ( dev-scheme/guile )
	tk? ( dev-lang/tk )"
DEPEND="${RDEPEND}
	x11-proto/xproto"

pkg_setup() {
	if use guile && has_version ">=dev-scheme/guile-1.8" \
		&& ! built_with_use ">=dev-scheme/guile-1.8" deprecated
	then
		eerror "In order to compile xbindkeys with guile-1.8 or higher, you need"
		eerror "to recompile dev-scheme/guile with the \"deprecated\" USE flag."
		die "Please re-emerge dev-scheme/guile with USE=\"deprecated\"."
	fi
}

src_compile() {
	local myconf
	use tk || myconf="${myconf} --disable-tk"
	use guile || myconf="${myconf} --disable-guile"

	econf ${myconf} || die "configure failed"
	emake DESTDIR=${D} || die "make failed"
}

src_install() {
	make DESTDIR=${D} BINDIR=/usr/bin install || die "make install failed"
}
