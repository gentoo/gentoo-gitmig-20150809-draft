# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-web/twisted-web-0.7.0.ebuild,v 1.3 2007/06/09 18:04:18 lavajoe Exp $

MY_PACKAGE=Web

inherit twisted eutils

DESCRIPTION="Twisted web server, programmable in Python"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"

DEPEND="=dev-python/twisted-2.5*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.5.0-root-skip.patch
}
