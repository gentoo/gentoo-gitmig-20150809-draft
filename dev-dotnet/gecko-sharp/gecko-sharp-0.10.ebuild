# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gecko-sharp/gecko-sharp-0.10.ebuild,v 1.2 2005/05/20 19:55:26 latexer Exp $

inherit mono

MY_P="${P/${PN}/${PN}-2.0}"

DESCRIPTION="A Gtk# Mozilla binding"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}-2.0/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc"
IUSE=""

S=${WORKDIR}/${MY_P}

DEPEND=">=dev-lang/mono-1.0
	>=dev-dotnet/gtk-sharp-1.9.2
	www-client/mozilla"

src_compile() {
	econf || die "./configure failed!"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	mv ${D}/usr/bin/webshot ${D}/usr/bin/webshot-2.0
	sed -i -e "s:nailer:nailer-2.0:" ${D}/usr/bin/webshot-2.0

	mv ${D}/usr/lib/gecko-sharp/WebThumbnailer.exe \
		${D}/usr/lib/gecko-sharp/WebThumbnailer-2.0.exe
}
