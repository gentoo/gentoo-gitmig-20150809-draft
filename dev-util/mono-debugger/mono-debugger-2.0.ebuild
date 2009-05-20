# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mono-debugger/mono-debugger-2.0.ebuild,v 1.3 2009/05/20 19:51:44 loki_val Exp $

inherit eutils mono

DESCRIPTION="Debugger for .NET managed and unmanaged applications"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://go-mono.com/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-lang/mono-2.0
		 sys-libs/readline"
DEPEND="${RDEPEND}
		!dev-lang/mercury
		>=dev-util/pkgconfig-0.20"

RESTRICT="test"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog AUTHORS NEWS
}
