# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/scmxlate/scmxlate-20060613.ebuild,v 1.1 2008/01/17 22:48:44 hkbst Exp $

DESCRIPTION="Scmxlate is a configuration tool for software packages written in Scheme."

HOMEPAGE="http://www.ccs.neu.edu/home/dorai/scmxlate/scmxlate.html"

#http://www.ccs.neu.edu/home/dorai/scmxlate/scmxlate.tar.gz
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="as-is"

SLOT="0"

KEYWORDS="~amd64"

IUSE=""

DEPEND=""

RDEPEND="${DEPEND}"

src_install() {
	insinto /usr/share/
	doins -r *
}
