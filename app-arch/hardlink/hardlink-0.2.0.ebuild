# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/hardlink/hardlink-0.2.0.ebuild,v 1.2 2012/05/19 10:50:58 ssuominen Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="A tool which replaces copies of a file with hardlinks"
HOMEPAGE="http://jak-linux.org/projects/hardlink/"
SRC_URI="http://jak-linux.org/projects/${PN}/${PN}_${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="dev-libs/libpcre"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

DOCS="README"

src_prepare() {
	sed -i -e '/^CF/s:?=:+=:' -e '/^CF/s:-O2 -g::' Makefile || die
}

src_compile() {
	tc-export CC
	emake
}
