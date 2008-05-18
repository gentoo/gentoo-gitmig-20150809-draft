# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/abs-guide/abs-guide-5.3.ebuild,v 1.1 2008/05/18 02:13:15 dirtyepic Exp $

KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"

DESCRIPTION="An advanced reference and a tutorial on bash shell scripting"
HOMEPAGE="http://www.tldp.org/LDP/abs/html"

# Upstream likes to repackage the tarball without changing the name.
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="OPL"
IUSE=""
SLOT="0"

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_install() {
	dodir /usr/share/doc/${P}       || die "dodir failed"
	cp -R * "${D}"/usr/share/doc/${P} || die "cp failed"
}
