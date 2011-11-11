# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-bjnp/cups-bjnp-1.0.ebuild,v 1.2 2011/11/11 13:46:43 vadimk Exp $

EAPI=4

DESCRIPTION="CUPS backend for the canon printers using the proprietary USB over IP BJNP protocol."
HOMEPAGE="http://sourceforge.net/projects/cups-bjnp/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="net-print/cups"
RDEPEND="${DEPEND}"
