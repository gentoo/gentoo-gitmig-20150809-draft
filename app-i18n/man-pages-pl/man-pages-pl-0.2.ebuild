# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-pl/man-pages-pl-0.2.ebuild,v 1.1 2012/05/19 10:35:42 nelchael Exp $

EAPI=4

MY_PN="${PN/-/}"

DESCRIPTION="A collection of Polish translations of Linux manual pages."
HOMEPAGE="https://sourceforge.net/projects/manpages-pl/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2 GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

DOCS=(AUTHORS CHANGELOG README)

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	man_pages_from_other_packesg="chfn.1 groups.1 login.1 su.1"
	for man_page in ${man_pages_from_other_packesg}; do
		find "${S}" -name "${man_page}" -exec rm -fv {} \;
	done

	sed -i -e 's,gzip,:,g' "${S}/Makefile" || die
}
