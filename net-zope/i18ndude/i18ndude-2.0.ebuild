# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/i18ndude/i18ndude-2.0.ebuild,v 1.2 2006/01/27 02:35:41 vapier Exp $

inherit distutils

DESCRIPTION="i18ndude is the swiss army knife for zope/plone/products translators"
HOMEPAGE="http://plone.org/products/i18ndude"
SRC_URI="http://plone.org/products/${PN}/releases/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=dev-python/pyxml-0.8.1"

S=${WORKDIR}/${PN}
