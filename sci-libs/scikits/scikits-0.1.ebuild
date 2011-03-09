# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/scikits/scikits-0.1.ebuild,v 1.3 2011/03/09 16:51:07 bicatali Exp $

EAPI="3"
SUPPORT_PYTHON_ABIS="1"
inherit python

DESCRIPTION="Common files for python scikits"
HOMEPAGE="http://projects.scipy.org/scipy/scikits"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}.example/${PN}.example-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

RDEPEND=""
DEPEND=""
S="${WORKDIR}"

src_install() {
	install_scikits() {
		insinto $(python_get_sitedir)/scikits
		doins scikits.example*/scikits/__init__.py || die
	}
	python_execute_function -q install_scikits
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r scikits.example*/* || die
	fi
}
