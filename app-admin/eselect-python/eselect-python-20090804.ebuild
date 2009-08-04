# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-python/eselect-python-20090804.ebuild,v 1.1 2009/08/04 20:53:43 arfrever Exp $

inherit toolchain-funcs

DESCRIPTION="Manages multiple Python versions"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=">=app-admin/eselect-1.0.2"
RDEPEND="${DEPEND}"

src_compile() {
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} -o python-wrapper python.c || die "Building of python wrapper failed"
}

src_install() {
	keepdir /etc/env.d/python

	dobin python-wrapper || die "dobin python-wrapper failed"

	insinto /usr/share/eselect/modules
	doins python.eselect || die "doins python.eselect failed"
}

pkg_preinst() {
	if has_version "<${CATEGORY}/${PN}-20090804"; then
		run_eselect_python_update="1"
	fi
}

pkg_postinst() {
	if [[ "${run_eselect_python_update}" == "1" ]]; then
		ebegin "Running \`eselect python update\`"
		eselect python update --ignore 3.0 --ignore 3.1 --ignore 3.2 > /dev/null
		eend "$?"
	fi
}
