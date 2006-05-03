# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-words/twisted-words-0.1.0-r1.ebuild,v 1.4 2006/05/03 23:04:51 halcy0n Exp $

MY_PACKAGE=Words

inherit twisted

DESCRIPTION="Twisted Words contains Instant Messaging implementations."

KEYWORDS="~amd64 ~ppc sparc x86"

DEPEND=">=dev-python/twisted-2
	dev-python/twisted-web
	dev-python/twisted-xish"
