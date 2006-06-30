# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-runner/twisted-runner-0.1.0-r1.ebuild,v 1.7 2006/06/30 23:11:52 tcort Exp $

MY_PACKAGE=Runner

inherit twisted

DESCRIPTION="Twisted Runner is a process management library and inetd replacement."

KEYWORDS="alpha ~ia64 ~ppc sparc x86"

DEPEND=">=dev-python/twisted-2
	<dev-python/twisted-2.4"

PROVIDE="virtual/inetd"
