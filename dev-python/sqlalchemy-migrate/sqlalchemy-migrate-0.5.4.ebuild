# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sqlalchemy-migrate/sqlalchemy-migrate-0.5.4.ebuild,v 1.3 2009/07/16 15:42:34 mr_bones_ Exp $

EAPI="2"

NEED_PYTHON=2.4

inherit distutils

DESCRIPTION="SQLAlchemy Schema Migration Tools"
HOMEPAGE="http://code.google.com/p/sqlalchemy-migrate/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-python/sqlalchemy
	dev-python/decorator"

DEPEND="dev-python/setuptools"
