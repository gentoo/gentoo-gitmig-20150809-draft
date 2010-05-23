# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdotool/xdotool-20091231.02.ebuild,v 1.6 2010/05/23 20:01:35 pacho Exp $

EAPI=2

inherit eutils toolchain-funcs flag-o-matic multilib

DESCRIPTION="Simulate keyboard input and mouse activity, move and resize windows."
HOMEPAGE="http://www.semicomplete.com/projects/xdotool/"
SRC_URI="http://semicomplete.googlecode.com/files/${P}.tar.gz"
LICENSE="as-is"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="examples"

DEPEND="x11-libs/libXtst
	x11-libs/libX11"

RDEPEND="${DEPEND}"

# The test want to manualy start Xvfb an wont use VirtualX and
# it tries to run a full gnome-session. For such a tiny application
# i consider it overkill to rewrite the test scripts to not use it's
# own X server and add a full blown gnome just to run the tests.
RESTRICT="test"

src_prepare() {
	epatch "${FILESDIR}/${P}_install-D.patch" \
		"${FILESDIR}/${P}_as-needed.patch"
}

src_compile() {
	tc-export CC LD
	# Seems to handle LDFLAGS fine without it and prevents QA message bug #312729
	#export LDFLAGS="$(raw-ldflags)"
	default
	emake libxdo.so || die "Unable to build libxdo.so"
}

src_install() {
	emake PREFIX="${D}usr" INSTALLMAN="${D}usr/share/man" INSTALLLIB="${D}usr/$(get_libdir)" install || die

	dodoc CHANGELIST README
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
	fi
}
