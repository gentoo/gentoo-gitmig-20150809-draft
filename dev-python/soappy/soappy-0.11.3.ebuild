# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/soappy/soappy-0.11.3.ebuild,v 1.8 2005/04/24 10:05:56 blubb Exp $

inherit distutils

MY_P="SOAPpy-${PV}"

DESCRIPTION="SOAP implementation for Python"
HOMEPAGE="http://pywebsvcs.sourceforge.net/"
SRC_URI="mirror://sourceforge/pywebsvcs/${MY_P}.tar.gz"

KEYWORDS="x86 ppc amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="dev-python/fpconst
		dev-python/pyxml"

S=${WORKDIR}/${MY_P}
