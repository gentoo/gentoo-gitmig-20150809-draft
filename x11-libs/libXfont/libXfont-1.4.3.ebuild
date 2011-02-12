# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXfont/libXfont-1.4.3.ebuild,v 1.9 2011/02/12 20:08:06 armin76 Exp $

EAPI=3
inherit xorg-2

DESCRIPTION="X.Org Xfont library"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
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
		--without-fop
		--with-encodingsdir=${EPREFIX}/usr/share/fonts/encodings"
}
