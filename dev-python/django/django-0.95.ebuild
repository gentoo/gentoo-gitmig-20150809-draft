# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django/django-0.95.ebuild,v 1.2 2006/08/13 15:40:12 lucass Exp $

inherit distutils

MY_P="${PN/d/D}-${PV}"
DESCRIPTION="high-level python web framework"
HOMEPAGE="http://www.djangoproject.com/"
SRC_URI="http://media.djangoproject.com/releases/${PV}/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="sqlite postgres mysql"

DEPEND=">=dev-lang/python-2.3
		>=dev-python/setuptools-0.6_rc1"

RDEPEND=">=dev-lang/python-2.3
		sqlite? ( >=dev-python/pysqlite-2.0.3 )
		postgres? ( <dev-python/psycopg-1.99 )
		mysql? ( dev-python/mysql-python )
		dev-python/imaging"

S="${WORKDIR}/${MY_P}"
DOCS="docs/* AUTHORS INSTALL LICENSE"

src_install()
{
	distutils_python_version

	site_pkgs="/usr/$(get_libdir)/python${PYVER}/site-packages/"
	export PYTHONPATH="${PYTHONPATH}:${D}/${site_pkgs}"
	dodir ${site_pkgs}

	distutils_src_install --single-version-externally-managed

	cp -r examples "${D}/usr/share/doc/${PF}"
}
