# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXt/libXt-1.0.9.ebuild,v 1.1 2010/10/28 22:00:14 scarabeus Exp $

EAPI=3
inherit xorg-2 toolchain-funcs

DESCRIPTION="X.Org Xt library"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libSM
	x11-libs/libICE"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/kbproto"

pkg_setup() {
	xorg-2_pkg_setup

	tc-is-cross-compiler && export CFLAGS_FOR_BUILD="${BUILD_CFLAGS}"
}
