# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim/scim-0.4.1.ebuild,v 1.1 2003/05/25 15:10:52 liquidx Exp $

inherit gnome2

DESCRIPTION="Smart Common Input Method (SCIM) is a Input Method (IM) development platform"
HOMEPAGE="http://www.gnuchina.org/~suzhe/scim/"
SRC_URI="http://www.gnuchina.org/~suzhe/scim/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="gtk"

RDEPEND="virtual/x11
	>=gnome-base/gconf-1.2
	>=dev-libs/libxml2-2.5
	>=gnome-base/ORBit2-2.5
	gtk? (	>=x11-libs/gtk+-2
		>=dev-libs/atk-1
		>=x11-libs/pango-1
		>=dev-libs/glib-2 )"
PDEPEND=">=app-i18n/scim-tables-0.2.1"

DEPEND="${RDEPEND}
	dev-lang/perl"
	

S=${WORKDIR}/${P}

src_compile() {
	local myconf
	use gtk ||  myconf="--disable-gtk2-immodule"
	econf ${myconf}
	emake || "make failed"
}

src_install() {
	einstall || "install failed"
	dodoc README AUTHORS ChangeLog docs/developers docs/scim.cfg
	dohtml -r docs/html/*
}

SCROLLKEEPER_UPDATE="0"
