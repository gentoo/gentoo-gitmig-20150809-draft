# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/suds/suds-0.3.9.ebuild,v 1.1 2010/05/30 09:23:07 cedk Exp $

EAPI=3
PYTHON_DEPEND="2"

inherit distutils

MY_P=${P/suds/python-suds}

DESCRIPTION="A lightweight SOAP python client"
HOMEPAGE="https://fedorahosted.org/suds/"
SRC_URI="https://fedorahosted.org/releases/s/u/suds/${MY_P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S=${WORKDIR}/${MY_P}
