# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/txAMQP/txAMQP-0.6.1.ebuild,v 1.1 2012/04/19 10:07:12 patrick Exp $

EAPI="3"

inherit distutils

DESCRIPTION="Python library for communicating with AMQP peers using Twisted"
HOMEPAGE="https://launchpad.net/txamqp"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}"
RDEPEND="${RDEPEND}
	dev-python/twisted"
