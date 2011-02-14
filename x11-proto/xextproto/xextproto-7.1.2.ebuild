# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/xextproto/xextproto-7.1.2.ebuild,v 1.10 2011/02/14 13:51:39 xarthisius Exp $

EAPI=3

inherit xorg-2

DESCRIPTION="X.Org XExt protocol headers"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~x86-fbsd ~x64-freebsd ~x86-freebsd ~ia64-hpux ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE="doc"

RDEPEND="!<x11-libs/libXext-1.0.99"
DEPEND="${RDEPEND}
	doc? (
		app-text/xmlto
		app-text/docbook-xml-dtd:4.1.2
		app-text/docbook-xml-dtd:4.3
	)"

pkg_setup() {
	CONFIGURE_OPTIONS="
		$(use_with doc xmlto)
		--without-fop
	"
}
