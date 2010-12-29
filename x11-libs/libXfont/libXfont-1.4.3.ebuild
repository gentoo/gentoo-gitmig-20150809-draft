# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXfont/libXfont-1.4.3.ebuild,v 1.6 2010/12/29 21:15:01 maekke Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org Xfont library"

KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ~ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE="doc ipv6"

RDEPEND="x11-libs/xtrans
	x11-libs/libfontenc
	>=media-libs/freetype-2
	app-arch/bzip2
	x11-proto/xproto
	x11-proto/fontsproto"
DEPEND="${RDEPEND}
	doc? ( app-text/xmlto )"

pkg_setup() {
	xorg-2_pkg_setup
	CONFIGURE_OPTIONS="$(use_enable ipv6)
		$(use_enable doc devel-docs)
		$(use_with doc xmlto)
		--with-bzip2
		--without-fop"
}
