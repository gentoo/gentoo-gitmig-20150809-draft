# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodoc/monodoc-0.11.ebuild,v 1.1 2004/03/25 23:38:39 tberman Exp $

inherit mono

DESCRIPTION="Documentation for mono's .Net class library"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://www.go-mono.com/archive/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-dotnet/mono-0.31
		>=x11-libs/gtk-sharp-0.17"

src_compile() {
	econf || die
	MAKEOPTS="-j1"
	make || die
	ewarn "If for some reason this failed, try: USE='gtkhtml' emerge gtk-sharp\n"
}

src_install() {
	einstall || die
}
