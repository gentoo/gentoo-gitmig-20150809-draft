# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/scmxlate/scmxlate-20090410.ebuild,v 1.1 2010/06/29 00:27:07 chiiph Exp $

EAPI="3"

DESCRIPTION="Scmxlate is a configuration tool for software packages written in Scheme"
HOMEPAGE="http://www.ccs.neu.edu/home/dorai/scmxlate/scmxlate.html"

SRC_URI="http://evalwhen.com/scmxlate/scmxlate.tar.bz2
	-> ${P}.tar.bz2"
#SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

S="${WORKDIR}/${PN}"

src_compile() { true; }

src_install() {
	insinto /usr/share/
	doins *.cl *.scm || die "doins failed"
	dodoc README || die "dodoc failed"
}
