# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/abs-guide/abs-guide-5.0.ebuild,v 1.8 2007/09/09 13:21:20 dirtyepic Exp $

DESCRIPTION="An advanced reference and a tutorial on bash shell scripting"
HOMEPAGE="http://www.tldp.org/LDP/abs/html"

# Upstream likes to repackage the tarball without changing the name.
SRC_URI="mirror://gentoo/${P}.tar.bz2"

S="${WORKDIR}"

IUSE=""
KEYWORDS="alpha amd64 hppa ~mips ppc sparc x86"
LICENSE="OPL"
SLOT="0"

src_install() {
	dodir /usr/share/doc/${P}       || die "dodir failed"
	cp -R * ${D}/usr/share/doc/${P} || die "cp failed"
}
