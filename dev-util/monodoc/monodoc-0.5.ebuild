# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodoc/monodoc-0.5.ebuild,v 1.3 2003/07/12 05:22:29 tberman Exp $

inherit mono

DESCRIPTION="Documentation for mono's .Net class library"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://www.go-mono.com/archive/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-lang/mono-0.25
		>=x11-libs/gtk-sharp-0.10"

src_compile() {
	econf || die
	MAKEOPTS="-j1"
	make || die
}

src_install() {
	einstall || die
}
