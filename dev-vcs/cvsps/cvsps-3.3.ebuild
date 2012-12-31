# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/cvsps/cvsps-3.3.ebuild,v 1.1 2012/12/31 20:36:09 slyfox Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="Generates patchset information from a CVS repository"
HOMEPAGE="http://www.catb.org/~esr/cvsps/"
SRC_URI="http://www.catb.org/~esr/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}
	app-text/asciidoc"

src_prepare() {
	sed -i 's/ -lz/& $(LDFLAGS)/' Makefile || die

	tc-export CC
	export prefix=${D}
}

src_install() {
	default
	dodoc README
}
