# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/soappy/soappy-0.11.6.ebuild,v 1.4 2005/02/12 19:35:15 fserb Exp $

inherit distutils

MY_P="SOAPpy-${PV}"

DESCRIPTION="SOAP implementation for Python"
HOMEPAGE="http://pywebsvcs.sourceforge.net/"
SRC_URI="mirror://sourceforge/pywebsvcs/${MY_P}.tar.gz"

KEYWORDS="~x86 ~ppc ~amd64 ~sparc ~ppc-macos"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=dev-python/fpconst-0.7.1
		dev-python/pyxml"

S=${WORKDIR}/${MY_P}
