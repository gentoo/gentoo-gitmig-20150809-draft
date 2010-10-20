# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/trac/trac-0.12.1.ebuild,v 1.1 2010/10/20 11:22:52 djc Exp $

EAPI="2"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils eutils webapp

MY_PV=${PV/_beta/b}
MY_P=Trac-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Trac is a minimalistic web-based project management, wiki and bug/issue tracking system."
HOMEPAGE="http://trac.edgewall.com/"
LICENSE="BSD"
SRC_URI="http://ftp.edgewall.com/pub/trac/${MY_P}.tar.gz"

IUSE="cgi fastcgi i18n mysql postgres +sqlite subversion"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

# doing so because tools, python packages... overlap
SLOT="0"
WEBAPP_MANUAL_SLOT="yes"

RDEPEND="
	dev-python/setuptools
	dev-python/docutils
	dev-python/genshi
	dev-python/pygments
	dev-python/pytz
	i18n? ( >=dev-python/Babel-0.9.5 )
	cgi? ( virtual/httpd-cgi )
	fastcgi? ( virtual/httpd-fastcgi )
	mysql? ( dev-python/mysql-python )
	postgres? ( >=dev-python/psycopg-2 )
	sqlite? (
		>=dev-db/sqlite-3.3.4
		|| (
			>=dev-lang/python-2.5[sqlite]
			>=dev-python/pysqlite-2.3.2
		)
	)
	subversion? ( dev-vcs/subversion[python] )
	!www-apps/trac-webadmin
	"
DEPEND="${RDEPEND}"
RESTRICT_PYTHON_ABIS="3.*"

pkg_setup() {
	python_pkg_setup
	webapp_pkg_setup

	if ! use mysql && ! use postgres && ! use sqlite; then
		eerror "You must select at least one database backend, by enabling"
		eerror "at least one of the 'mysql', 'postgres' or 'sqlite' USE flags."
		die "no database backend selected"
	fi

	enewgroup tracd
	enewuser tracd -1 -1 -1 tracd
}

src_test() {

	testing() {
		PYTHONPATH=. "$(PYTHON)" trac/test.py
	}
	python_execute_function testing

	if use i18n; then
		make check
	fi

}

# the default src_compile just calls setup.py build
# currently, this switches i18n catalog compilation based on presence of Babel

src_install() {
	webapp_src_preinst
	distutils_src_install

	# project environments might go in here
	keepdir /var/lib/trac

	# Use this as the egg-cache for tracd
	dodir /var/lib/trac/egg-cache
	keepdir /var/lib/trac/egg-cache
	fowners tracd:tracd /var/lib/trac/egg-cache

	# documentation
	cp -r contrib "${D}"/usr/share/doc/${P}/

	# tracd init script
	newconfd "${FILESDIR}"/tracd.confd tracd
	newinitd "${FILESDIR}"/tracd.initd tracd

	if use cgi; then
		cp cgi-bin/trac.cgi "${D}"/${MY_CGIBINDIR} || die
	fi
	if use fastcgi; then
		cp cgi-bin/trac.fcgi "${D}"/${MY_CGIBINDIR} || die
	fi

	for lang in en; do
		webapp_postinst_txt ${lang} "${FILESDIR}"/postinst-${lang}.txt
		webapp_postupgrade_txt ${lang} "${FILESDIR}"/postupgrade-${lang}.txt
	done

	webapp_src_install
}

pkg_postinst() {
	distutils_pkg_postinst
	webapp_pkg_postinst
}
