# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xchm/xchm-1.7.1.ebuild,v 1.2 2006/04/14 17:42:37 nelchael Exp $

inherit wxwidgets

DESCRIPTION="Utility for viewing Microsoft .chm files."
HOMEPAGE="http://xchm.sf.net"
SRC_URI="mirror://sourceforge/xchm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="unicode"
DEPEND=">=app-doc/chmlib-0.31
	>=x11-libs/wxGTK-2.6.0"

src_compile() {
	local myconf
	export WX_GTK_VER="2.6"
	if use unicode; then
		need-wxwidgets unicode
	else
		need-wxwidgets gtk2
	fi
	myconf="${myconf} --with-wx-config=${WX_CONFIG}"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS README

	# fixes dekstop and icon problems
	rm ${D}/usr/share/pixmaps/xchm-*.xpm
	${D}/usr/share/pixmaps/xchmdoc-*.xpm

	dodir /usr/share/icons/hicolor/16x16/apps/
	install -m 644 ${S}/art/xchm-16.xpm \
		${D}/usr/share/icons/hicolor/16x16/apps/xchm.xpm
	dodir /usr/share/icons/hicolor/32x32/apps/
	install -m 644 ${S}/art/xchm-32.xpm \
		${D}/usr/share/icons/hicolor/32x32/apps/xchm.xpm
	dodir /usr/share/icons/hicolor/48x48/apps/
	install -m 644 ${S}/art/xchm-48.xpm \
		${D}/usr/share/icons/hicolor/48x48/apps/xchm.xpm
	dodir /usr/share/icons/hicolor/128x128/apps/
	install -m 644 ${S}/art/xchm-128.xpm \
		${D}/usr/share/icons/hicolor/128x128/apps/xchm.xpm
	dodir /usr/share/icons/hicolor/16x16/mimetypes/
	install -m 644 ${S}/art/xchmdoc-16.xpm \
		${D}/usr/share/icons/hicolor/16x16/mimetypes/chm.xpm
	dodir /usr/share/icons/hicolor/32x32/mimetypes/
	install -m 644 ${S}/art/xchmdoc-32.xpm \
		${D}/usr/share/icons/hicolor/32x32/mimetypes/chm.xpm
	dodir /usr/share/icons/hicolor/48x48/mimetypes/
	install -m 644 ${S}/art/xchmdoc-48.xpm \
		${D}/usr/share/icons/hicolor/48x48/mimetypes/chm.xpm
	dodir /usr/share/icons/hicolor/128x128/mimetypes/
	install -m 644 ${S}/art/xchmdoc-128.xpm \
		${D}/usr/share/icons/hicolor/128x128/mimetypes/chm.xpm
	make_desktop_entry xchm XCHM xchm
}
