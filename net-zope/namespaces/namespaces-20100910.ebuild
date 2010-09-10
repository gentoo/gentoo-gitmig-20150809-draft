# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/namespaces/namespaces-20100910.ebuild,v 1.1 2010/09/10 21:58:00 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="*"
SUPPORT_PYTHON_ABIS="1"

inherit python

DESCRIPTION="Products, Shared and Shared.DC namespaces for Zope"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/setuptools"

src_install() {
	installation() {
		local module
		for module in Products Shared Shared/DC; do
			dodir $(python_get_sitedir)/${module} || return 1
			echo "__import__('pkg_resources').declare_namespace(__name__)" > "${ED}$(python_get_sitedir)/${module}/__init__.py" || return 1
		done
	}
	python_execute_function installation
}

pkg_postinst() {
	python_mod_optimize Products/__init__.py Shared/__init__.py Shared/DC/__init__.py
}

pkg_postrm() {
	python_mod_cleanup Products/__init__.py Shared/__init__.py Shared/DC/__init__.py
}
