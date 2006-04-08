# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-lore/twisted-lore-0.1.0-r1.ebuild,v 1.4 2006/04/08 06:10:24 nixnut Exp $

MY_PACKAGE=Lore

inherit twisted

DESCRIPTION="Twisted documentation system"

KEYWORDS="~ia64 ~ppc sparc ~x86"

DEPEND=">=dev-python/twisted-2
	dev-python/twisted-web"
