# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-news/twisted-news-0.2.0.ebuild,v 1.6 2007/01/03 02:37:39 beandog Exp $

MY_PACKAGE=News

inherit twisted

DESCRIPTION="Twisted News is an NNTP server and programming library."

KEYWORDS="alpha amd64 ia64 ~ppc ~sparc ~x86"

DEPEND=">=dev-python/twisted-2.4
	dev-python/twisted-mail"
