# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nevow/nevow-0.2.0.ebuild,v 1.1 2004/06/07 14:54:37 lordvan Exp $

inherit distutils

# for alphas,..
MY_PV="${PV/_alpha/alpha}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Nevow is a next-generation web application templating system, based on the ideas developed in the Twisted Woven package."
HOMEPAGE="http://www.nevow.com/"
#SRC_URI="http://www.nevow.com/${P}.tar.gz"
SRC_URI="http://www.divmod.org/users/release/divmod/Nevow-${MY_PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha"
IUSE=""

DEPEND=">=dev-python/twisted-1.3.0"

S=${WORKDIR}/${MY_P}

src_install() {
	distutils_src_install

	dodoc README

	# other docs are in subdirs so i use cp -r instead of insinto
	cp -r ${S}/doc ${D}/usr/share/doc/${PF}/
	cp -r ${S}/examples ${D}/usr/share/doc/${PF}/

	# FIXME:
	# should i install tutorial,pdfs,.. when USE="doc"?
}