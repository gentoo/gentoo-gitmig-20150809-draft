# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/flexget/flexget-9999.ebuild,v 1.25 2012/11/01 04:48:06 floppym Exp $

EAPI=4

PYTHON_COMPAT=( python2_{6,7} )

inherit distutils-r1 eutils

if [[ ${PV} != 9999 ]]; then
	MY_P="FlexGet-${PV/_beta/r}"
	SRC_URI="http://download.flexget.com/unstable/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	inherit subversion
	SRC_URI=""
	ESVN_REPO_URI="http://svn.flexget.com/trunk"
	KEYWORDS=""
fi

DESCRIPTION="Multipurpose automation tool for content like torrents, nzbs, podcasts, comics"
HOMEPAGE="http://flexget.com/"

LICENSE="MIT"
SLOT="0"
IUSE="test"

DEPEND="
	>=dev-python/feedparser-5.1.2
	>=dev-python/sqlalchemy-0.7
	dev-python/pyyaml
	dev-python/beautifulsoup:python-2
	dev-python/beautifulsoup:4
	dev-python/html5lib
	dev-python/jinja
	dev-python/PyRSS2Gen
	dev-python/pynzb
	dev-python/progressbar
	dev-python/flask
	dev-python/cherrypy
	dev-python/python-dateutil
	=dev-python/requests-0.14*
	dev-python/setuptools
	virtual/python-argparse[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
DEPEND+=" test? ( dev-python/nose )"

if [[ ${PV} == 9999 ]]; then
	DEPEND+=" dev-python/paver"
else
	S="${WORKDIR}/${MY_P}"
fi

python_prepare_all() {
	# Prevent setup from grabbing nose from pypi
	sed -e /setup_requires/d \
		-e '/SQLAlchemy/s/, <0.8//' \
		-e '/BeautifulSoup/s/, <3.3//' \
		-e '/beautifulsoup4/s/, <4.2//' \
		-i pavement.py || die

	epatch_user

	if [[ ${PV} == 9999 ]]; then
		# Generate setup.py
		paver generate_setup || die
	fi
}

python_test() {
	esetup.py test
}
