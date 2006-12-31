# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xchm/xchm-1.2.ebuild,v 1.6 2006/12/31 23:06:47 dirtyepic Exp $

inherit eutils wxwidgets

DESCRIPTION="Utility for viewing Microsoft .chm files."
HOMEPAGE="http://xchm.sf.net"
SRC_URI="mirror://sourceforge/xchm/${P}.tar.gz
	doc? ( mirror://sourceforge/xchm/${P}-doc.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"

IUSE="doc unicode"
DEPEND=">=app-doc/chmlib-0.31
	=x11-libs/wxGTK-2.6*"

src_unpack() {

	unpack ${A}

	# Fixes bug #117798:
	epatch "${FILESDIR}/${PN}-gcc41.patch"

}

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

	if use doc; then
		cd ${S}"-doc"
		dohtml html/*
	fi

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
