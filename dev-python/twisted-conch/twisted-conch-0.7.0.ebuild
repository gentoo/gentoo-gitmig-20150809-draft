# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-conch/twisted-conch-0.7.0.ebuild,v 1.11 2007/07/11 06:19:48 mr_bones_ Exp $

MY_PACKAGE=Conch

inherit twisted eutils

DESCRIPTION="Twisted SSHv2 implementation."

KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"

DEPEND="=dev-python/twisted-2.4*
	>=dev-python/pycrypto-1.9_alpha6"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-0.6.0-root-skip.patch"
}
