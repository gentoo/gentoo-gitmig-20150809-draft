# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/cbind/cbind-6.0.ebuild,v 1.7 2008/12/08 10:32:32 george Exp $

# !NOTE!
# this is a utility, no libs generated, no reason to do the gnat.eclass dance
# so, "inherit gnat" should not appear here!

DESCRIPTION="This tool is designed to aid in the creation of Ada bindings to C."
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.rational.com/"
LICENSE="GMGPL"

DEPEND="virtual/ada"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

src_compile() {
	MAKEOPTS="${MAKEOPTS} -j1" emake || die
}

src_install () {
	make PREFIX="${D}"/usr/ install || die
	dodoc README DOCS
}
