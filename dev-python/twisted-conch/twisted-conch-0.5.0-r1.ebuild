# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-conch/twisted-conch-0.5.0-r1.ebuild,v 1.2 2006/04/03 21:42:41 gustavoz Exp $

MY_PACKAGE=Conch

inherit twisted

DESCRIPTION="Twisted SSHv2 implementation."

KEYWORDS="~amd64 sparc ~x86"

DEPEND=">=dev-python/twisted-2
	>=dev-python/pycrypto-1.9_alpha6"
