# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodoc/monodoc-0.16.ebuild,v 1.5 2004/10/26 21:53:58 latexer Exp $

inherit mono

DESCRIPTION="Documentation for mono's .Net class library"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://www.go-mono.com/archive/beta2/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=dev-dotnet/mono-0.95
		>=dev-dotnet/gtk-sharp-0.93"

pkg_setup() {
	# This is needed as monodoc emerges just hang if previous versions are around
	if has_version "<dev-util/monodoc-${PV}"
	then
		echo
		eerror "Currently, monodoc fails if attempting to upgrade from a"
		eerror "previous installation. Please unmerge monodoc, and then"
		eerror "re-emerge it. See bug #52818 for details."
		die "Previous monodoc installation detected."
	fi
}

src_compile() {
	econf || die
	MAKEOPTS="-j1"
	make || {
		echo
		ewarn "If for some reason this fails, try adding 'gtkhtml' to your USE variables, re-emerge gtk-sharp, then emerge monodoc"
		die "make failed"
	}
}

src_install() {
	make DESTDIR=${D} install || die
}
