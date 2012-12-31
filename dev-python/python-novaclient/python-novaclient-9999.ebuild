# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-novaclient/python-novaclient-9999.ebuild,v 1.1 2012/12/31 18:25:42 prometheanfire Exp $

EAPI=3
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils git-2

EGIT_REPO_URI="git://github.com/openstack/${PN}.git
	https://github.com/openstack/${PN}.git"

DESCRIPTION="This is a client for the OpenStack Nova API."
HOMEPAGE="https://github.com/openstack/python-novaclient"
#SRC_URI="git://github.com/openstack/python-novaclient.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="dev-python/setuptools
		test? ( dev-python/nose
				dev-python/mock )"
RDEPEND="virtual/python-argparse
		dev-python/httplib2
		dev-python/prettytable
		dev-python/simplejson"
