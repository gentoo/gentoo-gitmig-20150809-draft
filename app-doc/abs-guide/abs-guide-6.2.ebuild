# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/abs-guide/abs-guide-6.2.ebuild,v 1.2 2011/01/23 06:53:14 dirtyepic Exp $

KEYWORDS="alpha amd64 hppa ~mips ppc sparc x86"

DESCRIPTION="An advanced reference and a tutorial on bash shell scripting"
HOMEPAGE="http://www.tldp.org/LDP/abs/html"

# Upstream likes to update the tarball without changing the name.
# - fetch http://bash.webofcrafts.net/abs-guide-latest.tar.bz2
#   rename to abs-guide-${PV}.tar.bz2
# - fetch http://bash.webofcrafts.net/abs-guide.pdf
#   rename to abs-guide-${PV}.pdf
SRC_URI="mirror://gentoo/${P}.tar.bz2
		pdf? ( mirror://gentoo/${P}.pdf )"

LICENSE="OPL"
IUSE="pdf"
SLOT="0"

DEPEND=""
RDEPEND=""

S="${WORKDIR}/abs"

src_unpack() {
	unpack ${P}.tar.bz2
	use pdf && cp "${DISTDIR}"/${P}.pdf "${S}"
	cd "${S}"
}

src_install() {
	dodir /usr/share/doc/${P}                          || die "dodir failed"
	cp -R * "${D}"/usr/share/doc/${P}                  || die "cp failed"
	use pdf && { cp ${P}.pdf "${D}"/usr/share/doc/${P} || die "pdf failed"; }
}
