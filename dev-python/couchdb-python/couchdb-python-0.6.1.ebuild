# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/couchdb-python/couchdb-python-0.6.1.ebuild,v 1.1 2009/12/14 14:46:39 djc Exp $

EAPI="2"

inherit distutils

DESCRIPTION="Python library for working with CouchDB"
HOMEPAGE="http://code.google.com/p/couchdb-python/"
SRC_URI="http://pypi.python.org/packages/source/C/CouchDB/CouchDB-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-python/httplib2
	|| ( >=dev-lang/python-2.6
		( dev-lang/python:2.5 dev-python/simplejson )
		( dev-lang/python:2.4 dev-python/simplejson ) )
	doc? ( dev-python/epydoc )"
DEPEND=""

PYTHON_MODNAME="couchdb"
S=${WORKDIR}/CouchDB-${PV}

src_prepare() {
	distutils_src_prepare

	# Delete debug print (bug #278561).
	# Check if it is still needed in next version.
	sed -e "/print 'Using stdlib json'/d" -i couchdb/json.py || die "sed failed"
}

src_install() {
	distutils_src_install

	if use doc; then
		epydoc --config=doc/conf/epydoc.ini
	fi

	dohtml -r doc/* || die "dohtml failed"
}

src_test() {
	python setup.py test
}
