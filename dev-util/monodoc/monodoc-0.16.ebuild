# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodoc/monodoc-0.16.ebuild,v 1.2 2004/06/03 02:01:55 latexer Exp $

inherit mono

DESCRIPTION="Documentation for mono's .Net class library"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://www.go-mono.com/archive/beta2/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=dev-dotnet/mono-0.95
		>=x11-libs/gtk-sharp-0.93"

src_compile() {
	econf || die
	MAKEOPTS="-j1"
	make || {
		echo
		eerror "If you already have monodoc installed and this upgrade failed,"
		eerror "unmerge and then re-emerge monodoc."
		ewarn "If for some reason this fails, try adding 'gtkhtml' to your USE variables, re-emerge gtk-sharp, then emerge monodoc"
		die "make failed"
	}
}

src_install() {
	make DESTDIR=${D} install || die
}
