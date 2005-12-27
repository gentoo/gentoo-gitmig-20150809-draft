# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/i18ndude/i18ndude-2.0.ebuild,v 1.1 2005/12/27 18:16:53 radek Exp $

inherit distutils

DESCRIPTION="i18ndude is the swiss army knife for zope/plone/products translators."
SRC_URI="http://plone.org/products/${PN}/releases/${PV}/${P}.tar.gz"
HOMEPAGE="http://plone.org/products/i18ndude"

DEPEND=">=dev-lang/python-2.3
	>=dev-python/pyxml-0.8.1"

IUSE=""
SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

S="${WORKDIR}/${PN}"
