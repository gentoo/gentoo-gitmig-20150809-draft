# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/egenix-mx-base-py21/egenix-mx-base-py21-2.0.4.ebuild,v 1.7 2004/06/25 01:28:39 agriffis Exp $

PYTHON_SLOT_VERSION=2.1
inherit distutils

P_NEW="${PN%-py21}-${PV}"
S="${WORKDIR}/${P_NEW}"

DESCRIPTION="egenix utils for Python."
SRC_URI="http://www.lemburg.com/files/python/${P_NEW}.tar.gz"
HOMEPAGE="http://www.egenix.com/"
SLOT="0"
KEYWORDS="x86 ~ppc"
LICENSE="eGenixPublic"
IUSE=""

#please note, there is also a possibility to buy a commercial license
#from egenix.com

src_install() {
	distutils_src_install
	dohtml -a html -r mx
}
