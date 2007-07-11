# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-web/twisted-web-0.5.0-r3.ebuild,v 1.3 2007/07/11 06:19:47 mr_bones_ Exp $

MY_PACKAGE=Web

inherit twisted eutils

DESCRIPTION="Twisted web server, programmable in Python"

KEYWORDS="~alpha ~amd64 ia64 ~ppc ~sh ~sparc ~x86"

DEPEND=">=dev-python/twisted-2
	<dev-python/twisted-2.4"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-root-skip.patch"
	epatch "${FILESDIR}/${P}-tests-2.2-compat.patch"
}

src_install() {
	twisted_src_install

	# Get rid of the main user-visible bits of websetroots: the
	# wrapper script in bin and the manpage. This leaves behind the
	# script in scripts in site-packages. websetroot is removed
	# entirely in upstream svn and does not work in this version.
	rm -rf "${D}"/usr/{bin,share/man}
}
