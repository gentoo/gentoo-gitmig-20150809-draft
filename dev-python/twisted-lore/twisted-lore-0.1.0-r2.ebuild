# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-lore/twisted-lore-0.1.0-r2.ebuild,v 1.2 2006/06/30 23:06:31 tcort Exp $

MY_PACKAGE=Lore

inherit twisted eutils

DESCRIPTION="Twisted documentation system"

KEYWORDS="alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"

DEPEND=">=dev-python/twisted-2
	<dev-python/twisted-2.4
	dev-python/twisted-web"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# use python to figure out if dia is available instead of calling "which"
	epatch "${FILESDIR}/${P}-which.patch"
}
