# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-runner/twisted-runner-0.1.0-r1.ebuild,v 1.5 2006/05/03 23:04:18 halcy0n Exp $

MY_PACKAGE=Runner

inherit twisted

DESCRIPTION="Twisted Runner is a process management library and inetd replacement."

KEYWORDS="~ia64 ~ppc sparc x86"

DEPEND=">=dev-python/twisted-2"

PROVIDE="virtual/inetd"
