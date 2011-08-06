# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/sofia-sip/sofia-sip-1.12.11.ebuild,v 1.2 2011/08/06 08:37:25 zmedico Exp $

EAPI="4"

DESCRIPTION="RFC3261 compliant SIP User-Agent library"
HOMEPAGE="http://sofia-sip.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-linux"
IUSE="ssl"

RDEPEND="dev-libs/glib:2
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}"

# tests are broken, see bugs 304607 and 330261
RESTRICT="test"

src_configure() {
	econf $(use_with ssl openssl)
}
