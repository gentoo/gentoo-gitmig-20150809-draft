# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodoc/monodoc-0.15.ebuild,v 1.3 2004/06/25 02:41:06 agriffis Exp $

inherit mono

DESCRIPTION="Documentation for mono's .Net class library"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://www.go-mono.com/archive/beta1/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=dev-dotnet/mono-0.91
		>=x11-libs/gtk-sharp-0.91.1"

src_compile() {
	econf || die
	MAKEOPTS="-j1"
	make || die
	ewarn "If for some reason this failed, try: USE='gtkhtml' emerge gtk-sharp\n"
}

src_install() {
	make DESTDIR=${D} install || die
}
