# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gecko-sharp/gecko-sharp-0.10.ebuild,v 1.4 2005/05/31 12:14:57 herbs Exp $

inherit mono multilib

MY_P="${P/${PN}/${PN}-2.0}"

DESCRIPTION="A Gtk# Mozilla binding"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}-2.0/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S=${WORKDIR}/${MY_P}

DEPEND=">=dev-lang/mono-1.0
	>=dev-dotnet/gtk-sharp-1.9.2
	www-client/mozilla"

src_unpack() {
	unpack ${A}
	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e 's:^libdir.*:libdir=@libdir@:' \
			-e 's:${prefix}/lib:${libdir}:' \
			-e 's:$(prefix)/lib:$(libdir):' \
			${S}/{Makefile.*,*.pc.in} || die
		sed -i -e "s:GACUTIL_FLAGS=.*:GACUTIL_FLAGS=\'/root \$(DESTDIR)\$(libdir) \
				/package gecko-sharp-2.0 /gacdir \$(DESTDIR)\$(libdir)\':" \
			${S}/configure* || die
	fi
}

src_compile() {
	econf || die "./configure failed!"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die

	mv ${D}/usr/bin/webshot ${D}/usr/bin/webshot-2.0
	sed -i -e "s:nailer:nailer-2.0:" ${D}/usr/bin/webshot-2.0

	mv ${D}/usr/$(get_libdir)/gecko-sharp/WebThumbnailer.exe \
		${D}/usr/$(get_libdir)/gecko-sharp/WebThumbnailer-2.0.exe
}
