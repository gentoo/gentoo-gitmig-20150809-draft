# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-conch/twisted-conch-8.0.0.ebuild,v 1.1 2008/05/13 20:34:28 hawking Exp $

MY_PACKAGE=Conch

inherit twisted eutils

DESCRIPTION="Twisted SSHv2 implementation."

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND="=dev-python/twisted-8*
	>=dev-python/pycrypto-1.9_alpha6"
