# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mono-debugger/mono-debugger-0.4.ebuild,v 1.2 2003/07/25 13:12:03 tberman Exp $

inherit mono libtool

DESCRIPTION="Debugger for mono applications."
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://www.go-mono.com/archive/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-dotnet/mono-0.25-r1
		>=x11-libs/gtk-sharp-0.10
		x11-libs/libzvt"

src_compile() {
	elibtoolize
	EXTRA_ECONF='--disable-readline'
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
}
