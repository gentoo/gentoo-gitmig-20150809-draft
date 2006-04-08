# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-conch/twisted-conch-0.5.0-r1.ebuild,v 1.3 2006/04/08 06:05:22 nixnut Exp $

MY_PACKAGE=Conch

inherit twisted

DESCRIPTION="Twisted SSHv2 implementation."

KEYWORDS="~amd64 ~ppc sparc ~x86"

DEPEND=">=dev-python/twisted-2
	>=dev-python/pycrypto-1.9_alpha6"
