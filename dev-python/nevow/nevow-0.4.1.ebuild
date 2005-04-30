# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/nevow/nevow-0.4.1.ebuild,v 1.2 2005/04/30 10:21:17 dholm Exp $

inherit distutils

# for alphas,..
MY_PV="${PV/_alpha/alpha}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="Nevow is a next-generation web application templating system, based on the ideas developed in the Twisted Woven package."
HOMEPAGE="http://www.nevow.org/"
SRC_URI="http://www.nevow.org/releases/${PV}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND=">=dev-lang/python-2.2"

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
