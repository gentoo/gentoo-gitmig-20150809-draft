# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXaw/libXaw-1.0.7.ebuild,v 1.5 2009/12/15 19:34:28 ranger Exp $

EAPI="2"

inherit x-modular flag-o-matic

DESCRIPTION="X.Org Xaw library"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE="doc"

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXmu
	x11-libs/libXpm
	x11-proto/xproto"
DEPEND="${RDEPEND}
	doc? ( sys-apps/groff )
	"

pkg_setup() {
	# No such function yet
	# x-modular_pkg_setup

	# (#125465) Broken with Bdirect support
	filter-flags -Wl,-Bdirect
	filter-ldflags -Bdirect
	filter-ldflags -Wl,-Bdirect
}

src_configure() {
	CONFIGURE_OPTIONS="$(use_enable doc docs)"
	x-modular_src_configure
}
