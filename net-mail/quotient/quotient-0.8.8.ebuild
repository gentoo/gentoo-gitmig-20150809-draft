# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/quotient/quotient-0.8.8.ebuild,v 1.6 2004/07/19 22:10:00 kloeri Exp $

inherit distutils

MY_PN="Quotient"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Quotient is an open source product that combines a multi-protocol messaging server with tools for information management and retrieval. Quotient brings together your email, IM/IRC and IP telephony."
HOMEPAGE="http://www.twistedmatrix.com/"
SRC_URI="mirror://sourceforge/divmod/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-python/twisted-1.1.1
	>=mail-filter/spambayes-1.0_alpha9
	>=dev-python/imaging-1.1.4
	>=dev-python/lupy-0.1.5.5.1"

S=${WORKDIR}/${MY_P}
