# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdotool/xdotool-1.20100318.2737.ebuild,v 1.2 2010/09/12 21:18:08 phajdan.jr Exp $

EAPI=2

inherit eutils toolchain-funcs flag-o-matic multilib

DESCRIPTION="Simulate keyboard input and mouse activity, move and resize windows."
HOMEPAGE="http://www.semicomplete.com/projects/xdotool/"
SRC_URI="http://semicomplete.googlecode.com/files/${P}.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="examples"

DEPEND="x11-libs/libXtst
	x11-libs/libX11"

RDEPEND="${DEPEND}"

# The test want to manualy start Xvfb, wont use VirtualX and # it tries
# to run a full gnome-session. For such a tiny application # i consider
# it overkill to rewrite the test scripts to not use it's own X server
# and add a full blown gnome just to run the tests.
RESTRICT="test"

src_compile() {
	tc-export CC LD
	export LDFLAGS="$(raw-ldflags)"
	default
}

src_install() {
	emake PREFIX="${D}usr" INSTALLMAN="${D}usr/share/man" INSTALLLIB="${D}usr/$(get_libdir)" install || die

	dodoc CHANGELIST README
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
