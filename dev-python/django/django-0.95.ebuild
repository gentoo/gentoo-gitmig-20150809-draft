# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django/django-0.95.ebuild,v 1.3 2006/12/30 01:49:34 dev-zero Exp $

inherit distutils

MY_P="${PN/d/D}-${PV}"
DESCRIPTION="high-level python web framework"
HOMEPAGE="http://www.djangoproject.com/"
SRC_URI="http://media.djangoproject.com/releases/${PV}/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="sqlite postgres mysql"

RDEPEND="dev-python/imaging
	sqlite? ( || (
		( >=dev-python/pysqlite-2.0.3 <dev-lang/python-2.5 )
		>=dev-lang/python-2.5 ) )
	postgres? ( <dev-python/psycopg-1.99 )
	mysql? ( dev-python/mysql-python )"
DEPEND="${RDEPEND}
	>=dev-python/setuptools-0.6_rc3"

S=${WORKDIR}/${MY_P}

DOCS="docs/* AUTHORS INSTALL"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/ez_setup/d' \
		setup.py || die "sed failed"
}

src_install() {
	distutils_python_version

	site_pkgs="/usr/$(get_libdir)/python${PYVER}/site-packages/"
	export PYTHONPATH="${PYTHONPATH}:${D}/${site_pkgs}"
	dodir ${site_pkgs}

	distutils_src_install --single-version-externally-managed

	insinto /usr/share/doc/${PF}
	doins -r examples
}
