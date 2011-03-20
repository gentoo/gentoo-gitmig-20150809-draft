# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jed/jed-0.99.19.ebuild,v 1.7 2011/03/20 16:37:13 armin76 Exp $

EAPI=3

inherit versionator

MY_P=${PN}-$(replace_version_separator 2 '-')
DESCRIPTION="Console S-Lang-based editor"
HOMEPAGE="http://www.jedsoft.org/jed/"
SRC_URI="ftp://space.mit.edu/pub/davis/jed/v0.99/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE="X gpm xft"

RDEPEND=">=sys-libs/slang-2
	X? ( x11-libs/libX11
		xft? ( x11-libs/libXext
			x11-libs/libXft
			x11-libs/libXrender
			>=media-libs/freetype-2.0 ) )
	gpm? ( sys-libs/gpm )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	export JED_ROOT="${EPREFIX}/usr/share/jed"
	econf \
		$(use_enable gpm) \
		$(use_enable xft)
}

src_compile() {
	emake || die
	if use X; then
		emake xjed || die
	fi
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die

	dodoc INSTALL INSTALL.unx README changes.txt || die
	doinfo info/jed* || die

	insinto /etc
	doins lib/jed.conf || die

	# replace IDE mode with EMACS mode
	sed -i -e 's/\(_Jed_Default_Emulation = \).*/\1"emacs";/' \
		"${ED}"/etc/jed.conf || die "patching jed.conf failed"
}
