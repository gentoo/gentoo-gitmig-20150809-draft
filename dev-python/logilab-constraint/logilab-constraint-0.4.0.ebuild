# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-constraint/logilab-constraint-0.4.0.ebuild,v 1.7 2012/03/13 02:38:20 floppym Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

MY_P="${P#logilab-}"
DESCRIPTION="A finite domain constraints solver written in 100% pure Python"
HOMEPAGE="http://www.logilab.org/projects/constraint/"
SRC_URI="ftp://ftp.logilab.org/pub/constraint/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="doc"

DEPEND=""
RDEPEND=">=dev-python/logilab-common-0.12.0"

DOCS="doc/CONTRIBUTORS"
PYTHON_MODNAME="logilab/constraint"

src_install() {
	distutils_src_install

	delete_unneeded_files() {
		# Avoid collisions with dev-python/logilab-common.
		rm -f "${ED}$(python_get_sitedir)/logilab/__init__.py"
	}
	python_execute_function -q delete_unneeded_files

	if use doc; then
		dohtml doc/documentation.html
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}

pkg_postinst() {
	distutils_pkg_postinst
	if use x86 && ! has_version dev-python/psyco; then
		einfo ""
		einfo "Although it is not required, you should consider installing"
		einfo "\"dev-python/psyco\". It can speed up this module a lot."
		einfo ""
	fi
}
