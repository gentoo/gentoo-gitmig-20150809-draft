# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/sussen/sussen-0.22.ebuild,v 1.1 2006/05/29 17:07:47 pva Exp $

inherit gnome2 mono autotools

DESCRIPTION="Sussen is a tool that checks for vulnerabilities and configuration issues on computer systems"
HOMEPAGE="http://dev.mmgsecurity.com/projects/sussen/"
SRC_URI="http://dev.mmgsecurity.com/downloads//${PN}/${P}.tar.gz"
LICENSE="GPL-2"
IUSE="doc"
SLOT="0"
KEYWORDS="~x86 ~amd64"

RDEPEND="=dev-lang/mono-1.1*
	>=dev-dotnet/gtk-sharp-2.4
	>=dev-dotnet/gnome-sharp-2.4
	>=dev-dotnet/gconf-sharp-2.4
	>=dev-dotnet/glade-sharp-2.4
	gnome-base/gnome-panel"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/monodoc-1.1.8 )
	app-arch/rpm
	>=dev-util/intltool-0.34.2"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_compile () {
	econf ${myconf} || die "./configure failed"
	LANG=C emake -j1 || die
}

src_install () {
	make GACUTIL_FLAGS="/root ${D}/usr/$(get_libdir) /gacdir /usr/$(get_libdir) /package ${PN}" \
	DESTDIR=${D} install || die

	dodoc ${DOCS}

	einfo "sussen-applet is a GNOME applet. You can not run it directly from"
	einfo "the command line. Use GNOME panel to invoke it."
	einfo "You can also run it as the tray icon: sussen-applet --tray-icon"
	echo
	ewarn "sussen-editor is still work in progress. Just basic functionality is"
	ewarn "working (New, Save, Execute)."
	echo
}
