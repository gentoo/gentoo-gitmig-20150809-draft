# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-words/twisted-words-0.1.0-r1.ebuild,v 1.2 2006/04/03 21:51:39 gustavoz Exp $

MY_PACKAGE=Words

inherit twisted

DESCRIPTION="Twisted Words contains Instant Messaging implementations."

KEYWORDS="~amd64 sparc ~x86"

DEPEND=">=dev-python/twisted-2
	dev-python/twisted-web
	dev-python/twisted-xish"
