# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-runner/twisted-runner-0.1.0-r1.ebuild,v 1.1 2005/11/27 21:54:46 marienz Exp $

MY_PACKAGE=Runner

inherit twisted

DESCRIPTION="Twisted Runner is a process management library and inetd replacement."

KEYWORDS="~sparc ~x86"

DEPEND=">=dev-python/twisted-2"

PROVIDE="virtual/inetd"
