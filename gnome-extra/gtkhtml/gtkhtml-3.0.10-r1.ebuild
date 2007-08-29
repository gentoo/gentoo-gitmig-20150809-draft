# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gtkhtml/gtkhtml-3.0.10-r1.ebuild,v 1.3 2007/08/29 14:49:33 cardoe Exp $

inherit gnome2 eutils

DESCRIPTION="Lightweight HTML Rendering/Printing/Editing Engine"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="alpha amd64 arm hppa ia64 ppc sparc x86"
IUSE=""

RDEPEND="=gnome-extra/gal-1.99.11*
	>=net-libs/libsoup-1.99.28
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2.1
	>=gnome-base/libbonoboui-2.0
	>=gnome-base/libbonobo-2.0
	>=gnome-base/orbit-2.5.6
	>=gnome-base/gnome-vfs-2.1
	>=gnome-base/gail-1.1
	>=dev-libs/libxml2-2.5"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

USE_DESTDIR="1"
SCROLLKEEPER_UPDATE="0"
ELTCONF="--reverse-deps"

src_unpack() {
	unpack ${A}
	cd ${S}/src

	# bug 101970
	epatch ${FILESDIR}/${P}-no-extern-cluealigned.diff

	# bug 54244, patch for cjk input methods
	epatch ${FILESDIR}/${PN}-fix_preedit.patch
}
