# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/stress/stress-1.0.0.ebuild,v 1.6 2009/05/05 19:23:57 fauli Exp $

inherit flag-o-matic

MY_P="${PN}-${PV/_/}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Imposes stressful loads on different aspects of the system."
HOMEPAGE="http://weather.ou.edu/~apw/projects/stress"
SRC_URI="http://weather.ou.edu/~apw/projects/stress/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ppc64 ~sparc x86"
IUSE="static"

DEPEND="sys-apps/help2man"
RDEPEND=""

src_unpack() {
	unpack ${A}
	# Force rebuild of the manpage
	rm -f "${S}"/doc/stress.1
}

src_compile() {
	use static && append-ldflags -static
	econf
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog AUTHORS README
}
