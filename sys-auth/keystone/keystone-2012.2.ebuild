# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/keystone/keystone-2012.2.ebuild,v 1.1 2012/11/28 21:59:34 prometheanfire Exp $

EAPI=4

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Keystone is the Openstack authentication, authorization, and
service catalog written in Python."
HOMEPAGE="https://launchpad.net/keystone"
SRC_URI="http://launchpad.net/${PN}/folsom/${PV}/+download/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="folsom"
KEYWORDS="~amd64 ~x86"
IUSE="+sqlite mysql postgres ldap"

#todo, seperate out rdepend via use flags
DEPEND=""
RDEPEND="${DEPEND}
	dev-python/eventlet
	dev-python/greenlet
	dev-python/iso8601
	dev-python/lxml
	dev-python/passlib
	dev-python/paste
	dev-python/pastedeploy
	dev-python/python-daemon
	dev-python/python-pam
	dev-python/routes
	>=dev-python/sqlalchemy-migrate-0.7
	>=dev-python/webob-1.0.8
	virtual/python-argparse
	sqlite? ( dev-python/sqlalchemy[sqlite] )
	mysql? ( dev-python/sqlalchemy[mysql] )
	postgres? ( dev-python/sqlalchemy[postgres] )
	ldap? ( dev-python/python-ldap )
	( || (
		sys-auth/keystone[sqlite]
		sys-auth/keystone[mysql]
		sys-auth/keystone[postgres]
		sys-auth/keystone[ldap]
		) )
	"

src_install() {
	distutils_src_install
	newconfd "${FILESDIR}/keystone.confd" keystone
	newinitd "${FILESDIR}/keystone.initd" keystone

	diropts -m 0750
	dodir /var/run/keystone /var/log/keystone /etc/keystone
	keepdir /etc/keystone
	insinto /etc/keystone
	doins etc/keystone.conf.sample etc/logging.conf.sample
	doins etc/default_catalog.templates etc/policy.json
}
