# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-conch/twisted-conch-0.5.0-r1.ebuild,v 1.4 2006/04/29 19:01:44 marienz Exp $

MY_PACKAGE=Conch

inherit twisted eutils

DESCRIPTION="Twisted SSHv2 implementation."

KEYWORDS="~amd64 ~ppc sparc ~x86"

DEPEND=">=dev-python/twisted-2
	>=dev-python/pycrypto-1.9_alpha6"


src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-root-skip.patch"
}
