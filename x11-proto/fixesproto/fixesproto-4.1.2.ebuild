# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/fixesproto/fixesproto-4.1.2.ebuild,v 1.7 2011/02/12 21:46:36 armin76 Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org Fixes protocol headers"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris ~x86-winnt"
IUSE=""

RDEPEND=">=x11-proto/xextproto-7.0.99.1"
DEPEND="${RDEPEND}"
