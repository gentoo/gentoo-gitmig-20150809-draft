# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/ikvm-bin/ikvm-bin-0.14.ebuild,v 1.2 2005/05/19 22:24:53 latexer Exp $

inherit mono

MY_P=${P/-bin/}
MY_PN=${PN/-bin/}

DESCRIPTION="Java VM for .NET"
HOMEPAGE="http://www.ikvm.net/"
SRC_URI="http://www.go-mono.com/sources/${MY_PN}/${MY_P}.tar.gz"

LICENSE="as-is"

SLOT="0"
S=${WORKDIR}/${MY_P}

KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/mono-1.1
	!dev-dotnet/ikvm"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
