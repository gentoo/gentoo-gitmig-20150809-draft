# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/quotient/quotient-0.9.1.ebuild,v 1.1 2004/06/07 15:05:21 lordvan Exp $

inherit distutils

MY_PN="Quotient"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Quotient is an open source product that combines a multi-protocol messaging server with tools for information management and retrieval. Quotient brings together your email, IM/IRC and IP telephony."
HOMEPAGE="http://www.divmod.org/Home/Projects/Quotient/index.html"
#SRC_URI="mirror://sourceforge/divmod/${MY_P}.tar.gz"
SRC_URI="http://www.divmod.org/users/release/divmod/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk gtk2 doc"

DEPEND=">=dev-python/twisted-1.3.0
	>=mail-filter/spambayes-1.0_alpha9
	>=dev-python/Imaging-1.1.4
	>=dev-python/lupy-0.2.1
	>=dev-python/nevow-0.2.0"

S=${WORKDIR}/${MY_P}
