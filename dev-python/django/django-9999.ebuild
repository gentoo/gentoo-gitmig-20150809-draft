# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django/django-9999.ebuild,v 1.3 2009/05/18 14:58:48 arfrever Exp $

EAPI="2"

ESVN_REPO_URI="http://code.djangoproject.com/svn/django/trunk/"

inherit bash-completion distutils eutils subversion versionator

DESCRIPTION="High-level python web framework"
HOMEPAGE="http://www.djangoproject.com/"
LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="doc examples mysql postgres sqlite test"

RDEPEND="dev-python/imaging
	sqlite? ( || (
		( dev-python/pysqlite:2 <dev-lang/python-2.5 )
		>=dev-lang/python-2.5[sqlite] ) )
	test? ( || (
		( dev-python/pysqlite:2 <dev-lang/python-2.5 )
		>=dev-lang/python-2.5[sqlite] ) )
	postgres? ( dev-python/psycopg )
	mysql? ( >=dev-python/mysql-python-1.2.1_p2 )"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-0.3 )"

S="${WORKDIR}"

DOCS="docs/*.txt AUTHORS"

src_compile() {
	distutils_src_compile

	if use doc ; then
		pushd docs > /dev/null
		emake html || die "Generation of HTML documentation failed"
		popd > /dev/null
	fi
}

src_test() {
	einfo "Running tests."
	cat >> tests/settings.py << __EOF__
DATABASE_ENGINE='sqlite3'
ROOT_URLCONF='tests/urls.py'
SITE_ID=1
__EOF__

	elog "Please note: You're using a live SVN ebuild."
	elog "We therefore won't fix any failures in the tests."
	elog "If you think it's django's fault report it to upstream."
	elog "Otherwise either disable the tests or use a stable version."
	PYTHONPATH="." ${python} tests/runtests.py --settings=settings -v1 || die "tests failed"
}

src_install() {
	distutils_python_version
	site_pkgs="$(python_get_sitedir)"
	export PYTHONPATH="${PYTHONPATH}:${D}/${site_pkgs}"
	dodir ${site_pkgs}

	distutils_src_install

	dobin django/bin/{compile-messages,daily_cleanup,make-messages,unique-messages,profiling/gather_profile_stats}.py
	doman docs/man/*

	dobashcompletion extras/django_bash_completion

	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi

	if use doc ; then
		dohtml -A txt -r docs/_build/html/*
	fi
}
