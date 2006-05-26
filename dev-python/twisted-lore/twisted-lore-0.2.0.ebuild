# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-lore/twisted-lore-0.2.0.ebuild,v 1.1 2006/05/26 18:43:37 marienz Exp $

MY_PACKAGE=Lore

inherit twisted

DESCRIPTION="Twisted documentation system"

KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"

DEPEND=">=dev-python/twisted-2.4
	dev-python/twisted-web"
