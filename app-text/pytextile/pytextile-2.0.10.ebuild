# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pytextile/pytextile-2.0.10.ebuild,v 1.6 2006/01/11 14:27:08 dertobi123 Exp $

inherit distutils

MY_P=${P/py//}

DESCRIPTION="A python implementation of Textile, Dean Allen's Human Text Generator. Textile simplifies the work of creating (X)HTML."
HOMEPAGE="http://dealmeida.net/en/Projects/PyTextile/"
SRC_URI="http://dealmeida.net/code/${MY_P}.tar.gz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""

DEPEND="dev-lang/python"

S=${WORKDIR}/${MY_P}
