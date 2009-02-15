# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherrytemplate/cherrytemplate-1.0.0.ebuild,v 1.6 2009/02/15 22:06:08 patrick Exp $

NEED_PYTHON=2.3

inherit distutils

MY_P="CherryTemplate-${PV}"
DESCRIPTION="Easy and powerful templating module for Python"
HOMEPAGE="http://cherrytemplate.python-hosting.com/"
SRC_URI="mirror://sourceforge/cherrypy/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${MY_P}
