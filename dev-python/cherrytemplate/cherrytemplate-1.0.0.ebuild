# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/cherrytemplate/cherrytemplate-1.0.0.ebuild,v 1.2 2005/07/12 11:01:22 dholm Exp $

inherit distutils

MY_P="CherryTemplate-${PV}"
DESCRIPTION="Easy and powerful templating module for Python"
HOMEPAGE="http://sourceforge.net/projects/cherrypy"
SRC_URI="mirror://sourceforge/cherrypy/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86"

IUSE=""
DEPEND=">=dev-lang/python-2.3"
S=${WORKDIR}/${MY_P}

