# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mono-debugger/mono-debugger-0.6.ebuild,v 1.2 2004/04/02 01:57:05 latexer Exp $

inherit mono libtool eutils

DESCRIPTION="Debugger for mono applications."
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://www.go-mono.com/archive/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-dotnet/mono-0.25-r1"

src_unpack() {
	unpack ${A}

	if ! have_NPTL
	then
		eerror "mono-debugger requires you to have NPTL support in glibc."
		eerror "To this, you need to re-emerge glibc with 2.6 kernel headers."
		eerror "Optionally, remove 'nptl' from your USE flags to make ebuilds"
		eerror "not depend on mono-debugger (such as monodevelop)."
		die "No support for NPTL found in glibc!"
	fi
}

src_compile() {
	elibtoolize
	EXTRA_ECONF='--disable-readline'
	econf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
}
