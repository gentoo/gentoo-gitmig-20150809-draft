# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gecko-sharp/gecko-sharp-0.7-r1.ebuild,v 1.2 2005/05/17 15:21:20 slarti Exp $

inherit mono eutils

DESCRIPTION="A Gtk# Mozilla binding"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/1.1.5/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=dev-lang/mono-1.0
	>=dev-dotnet/gtk-sharp-1.9.3
	www-client/mozilla"

S="${WORKDIR}/${PN}-2.0-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-1.9.3-compat.diff
}

src_compile() {
	econf || die "./configure failed!"
	emake -j1 || die "Make failed. You may need to unmerge gecko-sharp and re-emerge it if you are upgrading from an earlier version."
}

src_install() {
	make DESTDIR=${D} install || die

	mv ${D}/usr/bin/webshot ${D}/usr/bin/webshot-2.0
	sed -i -e "s:nailer:nailer-2.0:" ${D}/usr/bin/webshot-2.0

	mv ${D}/usr/lib/gecko-sharp/WebThumbnailer.exe \
		${D}/usr/lib/gecko-sharp/WebThumbnailer-2.0.exe
}
