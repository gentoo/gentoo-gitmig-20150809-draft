# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django/django-0.91.ebuild,v 1.3 2006/03/30 16:58:31 lucass Exp $

inherit distutils

MY_P="${PN/d/D}-${PV}"
DESCRIPTION="high-level python web framework"
HOMEPAGE="http://www.djangoproject.com/"
SRC_URI="http://media.djangoproject.com/releases/${PV}/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sqlite postgres mysql"

DEPEND=">=dev-lang/python-2.3
		dev-python/setuptools"

RDEPEND=">=dev-lang/python-2.3
		sqlite? ( >=dev-python/pysqlite-2.0.3 )
		postgres? ( dev-python/psycopg )
		mysql? ( dev-python/mysql-python )"

S="${WORKDIR}/${MY_P}"
DOCS="docs/* AUTHORS INSTALL LICENSE"

src_install()
{
	distutils_python_version

	site_pkgs="/usr/$(get_libdir)/python${PYVER}/site-packages/"
	export PYTHONPATH="${PYTHONPATH}:${D}/${site_pkgs}"
	dodir ${site_pkgs}

	distutils_src_install --single-version-externally-managed
}
