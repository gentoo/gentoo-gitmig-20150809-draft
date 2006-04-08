# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-words/twisted-words-0.1.0-r1.ebuild,v 1.3 2006/04/08 06:21:45 nixnut Exp $

MY_PACKAGE=Words

inherit twisted

DESCRIPTION="Twisted Words contains Instant Messaging implementations."

KEYWORDS="~amd64 ~ppc sparc ~x86"

DEPEND=">=dev-python/twisted-2
	dev-python/twisted-web
	dev-python/twisted-xish"
