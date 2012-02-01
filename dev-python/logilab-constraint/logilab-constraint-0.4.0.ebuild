# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/logilab-constraint/logilab-constraint-0.4.0.ebuild,v 1.5 2012/02/01 02:19:31 floppym Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils multilib

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

RESTRICT_PYTHON_ABIS="3*"

PYTHON_MODNAME="logilab/constraint"

DOCS="doc/CONTRIBUTORS"

src_install() {
	distutils_src_install

	# Avoid conflict with dev-python/logilab-common.
	rm -f "${D}"usr/$(get_libdir)/python*/site-packages/logilab/__init__.py

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
