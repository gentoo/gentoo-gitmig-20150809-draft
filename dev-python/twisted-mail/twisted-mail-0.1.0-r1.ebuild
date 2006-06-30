# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-mail/twisted-mail-0.1.0-r1.ebuild,v 1.6 2006/06/30 23:09:28 tcort Exp $

MY_PACKAGE=Mail

inherit twisted

DESCRIPTION="A Twisted Mail library, server and client."

KEYWORDS="alpha ~ppc sparc x86"

DEPEND=">=dev-python/twisted-2
	<dev-python/twisted-2.4
	dev-python/twisted-names"
