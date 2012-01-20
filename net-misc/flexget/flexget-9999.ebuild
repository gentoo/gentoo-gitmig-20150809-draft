# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/flexget/flexget-9999.ebuild,v 1.7 2012/01/20 05:54:22 floppym Exp $

EAPI=4

PYTHON_DEPEND="2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils subversion

DESCRIPTION="Multipurpose automation tool for content like torrents, nzbs, podcasts, comics, etc"
HOMEPAGE="http://flexget.com/"
SRC_URI=""
ESVN_REPO_URI="http://svn.flexget.com/trunk"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="deluge test transmission"

RDEPEND="
	>=dev-python/feedparser-5.1
	>=dev-python/sqlalchemy-0.7
	dev-python/pyyaml
	dev-python/beautifulsoup:python-2
	dev-python/html5lib
	dev-python/jinja
	dev-python/PyRSS2Gen
	dev-python/pynzb
	dev-python/progressbar
	dev-python/flask
	dev-python/cherrypy
	>=dev-python/requests-0.9.1
"
DEPEND="
	dev-python/setuptools
	dev-python/paver
	test? ( ${RDEPEND} dev-python/nose )
"
RDEPEND+="
	dev-python/setuptools
	deluge? ( net-p2p/deluge )
	transmission? ( dev-python/transmissionrpc )
"

src_prepare() {
	# Prevent setup from grabbing nose from pypi
	sed -e /setup_requires/d -i pavement.py || die

	# Generate setup.py
	paver generate_setup || die

	epatch_user
	distutils_src_prepare
}
