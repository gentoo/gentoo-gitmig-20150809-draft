# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnomesword/gnomesword-2.1.1.ebuild,v 1.8 2005/03/25 18:49:14 blubb Exp $

inherit libtool gnome2 eutils

DESCRIPTION="Gnome Bible study software"
HOMEPAGE="http://gnomesword.sf.net/"
SRC_URI="mirror://sourceforge/gnomesword/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="spell"

RDEPEND="=gnome-extra/libgtkhtml-3.0*
	>=app-text/sword-1.5.8_pre1
	>=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	=gnome-extra/gal-1.99*
	dev-libs/libxml2
	virtual/libc
	spell? ( app-text/gnome-spell
	>=gnome-base/libbonoboui-2 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12
	>=dev-util/intltool-0.29
	>=app-text/scrollkeeper-0.3.14"

G2CONF="${G2CONF} --enable-sword_cvs $(use_enable spell pspell)"
DOCS="COPYING NEWS ChangeLog README TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gnomesword-2.1.1-gcc-3.4.patch
}
