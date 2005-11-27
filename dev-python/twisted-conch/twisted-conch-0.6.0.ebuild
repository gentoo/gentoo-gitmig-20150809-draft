# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-conch/twisted-conch-0.6.0.ebuild,v 1.1 2005/11/27 21:12:36 marienz Exp $

MY_PACKAGE=Conch

inherit twisted eutils

DESCRIPTION="Twisted SSHv2 implementation."

KEYWORDS="~amd64 ~sparc ~x86"

DEPEND=">=dev-python/twisted-2.1
	>=dev-python/pycrypto-1.9_alpha6"
