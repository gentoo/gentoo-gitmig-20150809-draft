# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pytextile/pytextile-2.0.10.ebuild,v 1.9 2007/05/15 16:45:31 beandog Exp $

inherit distutils

MY_P=${P/py//}

DESCRIPTION="A python implementation of Textile, Dean Allen's Human Text Generator. Textile simplifies the work of creating (X)HTML."
HOMEPAGE="http://dealmeida.net/pytextile/"
SRC_URI="http://dealmeida.net/public/${MY_P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/python"

S=${WORKDIR}/${MY_P}
