# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-names/twisted-names-0.1.0-r1.ebuild,v 1.7 2006/06/30 23:08:41 tcort Exp $

MY_PACKAGE=Names

inherit twisted

DESCRIPTION="A Twisted DNS implementation."

KEYWORDS="alpha ~amd64 ~ppc sparc x86"

DEPEND=">=dev-python/twisted-2
	<dev-python/twisted-2.4"
