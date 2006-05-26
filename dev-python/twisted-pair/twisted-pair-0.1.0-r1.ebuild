# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-pair/twisted-pair-0.1.0-r1.ebuild,v 1.7 2006/05/26 17:43:48 marienz Exp $

MY_PACKAGE=Pair

inherit twisted

DESCRIPTION="Twisted Pair contains low-level networking support."

KEYWORDS="~amd64 ~ia64 ~ppc sparc x86"

DEPEND=">=dev-python/twisted-2
	<dev-python/twisted-2.4"
