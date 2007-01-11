# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-words/twisted-words-0.4.0.ebuild,v 1.2 2007/01/11 22:20:21 marienz Exp $

MY_PACKAGE=Words

inherit twisted

DESCRIPTION="Twisted Words contains Instant Messaging implementations."

KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"

DEPEND="=dev-python/twisted-2.4*
	dev-python/twisted-web"
