# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-python/snmpy/snmpy-1.0_alpha4.ebuild,v 1.5 2002/08/16 02:49:58 murphy Exp $

TARNAME=snmpy-alpha-4
S=${WORKDIR}/${TARNAME}
DESCRIPTION="python SNMP interface"
SRC_URI="mirror://sourceforge/snmpy/${TARNAME}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/snmpy/"
LICENSE="CNRI"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/python
	>=net-analyzer/ucd-snmp-4.2.0"
RDEPEND="${DEPEND}"


mydocs="RELEASE-NOTES docs/docs.html"
inherit distutils
