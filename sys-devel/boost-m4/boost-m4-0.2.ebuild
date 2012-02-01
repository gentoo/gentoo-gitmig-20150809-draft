# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/boost-m4/boost-m4-0.2.ebuild,v 1.1 2012/02/01 02:21:01 binki Exp $

EAPI=4

DESCRIPTION="Another set of autoconf macros for compiling against boost"
HOMEPAGE="http://github.com/tsuna/boost.m4"
SRC_URI="${HOMEPAGE}/zipball/v${PV} -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"

src_unpack() {
	default

	# The github-generated zipball kludge.
	mv *-boost.m4-* ${P} || die
}

# boost.m4 has a buildsystem, but the distributer didn't use make dist
# so we'd have to eautoreconf to use it. For installing one file, this
# isn't worth it.
src_configure() { :; }

src_compile() { :; }

src_install() {
	insinto /usr/share/aclocal
	doins build-aux/boost.m4

	dodoc AUTHORS NEWS README THANKS
}
