# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pytextile/pytextile-2.1.3.ebuild,v 1.1 2009/04/03 18:48:35 patrick Exp $

inherit distutils

MY_P=${P/py//}

DESCRIPTION="A python implementation of Textile, Dean Allen's Human Text Generator. Textile simplifies the work of creating (X)HTML."
HOMEPAGE="http://cheeseshop.python.org/pypi/textile"
SRC_URI="http://cheeseshop.python.org/packages/source/t/textile/${MY_P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

S=${WORKDIR}/${MY_P}
