# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: gert@hobbiton.be (Gert)
# Maintainer: Jon Nelson <jnelson@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-python/snmpy/snmpy-1.0_alpha4.ebuild,v 1.1 2002/04/28 16:18:41 jnelson Exp $

TARNAME=snmpy-alpha-4
S=${WORKDIR}/${TARNAME}
DESCRIPTION="python SNMP interface"
SRC_URI="http://prdownloads.sourceforge.net/snmpy/${TARNAME}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/snmpy/"

DEPEND="virtual/python
	>=net-analyzer/ucd-snmp-4.2.0"
RDEPEND="${DEPEND}"

src_compile() {
	python setup.py build || die
}

src_install() {
	python setup.py install --root=${D} --prefix=/usr || die
	dodoc README ChangeLog RELEASE-NOTES docs/docs.html
}

