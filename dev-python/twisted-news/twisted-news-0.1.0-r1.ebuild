# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-news/twisted-news-0.1.0-r1.ebuild,v 1.6 2006/05/26 17:42:05 marienz Exp $

MY_PACKAGE=News

inherit twisted

DESCRIPTION="Twisted News is an NNTP server and programming library."

KEYWORDS="~ia64 ~ppc sparc x86"

DEPEND=">=dev-python/twisted-2
	<dev-python/twisted-2.4
	dev-python/twisted-mail"
