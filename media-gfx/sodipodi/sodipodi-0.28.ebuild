# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/sodipodi/sodipodi-0.28.ebuild,v 1.11 2004/01/30 05:51:02 drobbins Exp $

inherit flag-o-matic

DESCRIPTION="Vector illustration application for GNOME"
HOMEPAGE="http://sodipodi.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="xml2 nls bonobo wmf"

RDEPEND=">=gnome-base/gnome-print-0.35
	<gnome-extra/gal-1.99
	media-libs/gdk-pixbuf
	bonobo? ( gnome-base/bonobo )
	xml2? ( dev-libs/libxml2 )
	wmf? ( >=media-libs/libwmf-0.2.1 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${A}

	cd ${S}
	export WANT_AUTOCONF=2.5
	autoconf --force
}

src_compile() {
	append-flags `gnome-config --cflags gdk_pixbuf`
	econf \
		--enable-gnome \
		--enable-gnome-print \
		`use_with bonobo` \
		`use_with xml2 gnome-xml2` \
		`use_with wmf libwmf` \
		`use_enable nls` \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README NEWS TODO
}
