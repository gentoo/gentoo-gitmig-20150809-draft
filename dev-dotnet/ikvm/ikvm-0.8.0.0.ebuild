# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ikvm/ikvm-0.8.0.0.ebuild,v 1.6 2005/05/18 18:07:07 latexer Exp $

inherit mono

DESCRIPTION="Java VM for .NET"
HOMEPAGE="http://www.ikvm.net/"

SRC_URI="http://www.go-mono.com/archive/1.0/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"

KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND=">=dev-lang/mono-1.0"
DEPEND="${RDEPEND}
		!dev-dotnet/ikvm-bin"

src_unpack() {
	unpack ${A}

	# Fix some makefile borkage.
	sed -i -e 's:-e$:-e \\:' ${S}/scripts/Makefile.in
}

src_compile() {
	econf || die
}

src_install() {
	make DESTDIR=${D} install || die
}
