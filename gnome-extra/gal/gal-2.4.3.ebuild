# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gal/gal-2.4.3.ebuild,v 1.8 2005/08/22 18:29:39 ferdy Exp $

inherit libtool eutils gnome2

DESCRIPTION="The Gnome Application Libraries"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="2.4"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="doc static"

RDEPEND=">=x11-libs/gtk+-2.2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2.1
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnomecanvas-2.2.0.2
	>=dev-libs/libxml2-2"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	>=dev-util/intltool-0.27.1
	doc? ( >=dev-util/gtk-doc-1 )"

MAKEOPTS="${MAKEOPTS} -j1"
USE_DESTDIR="1"
ELTCONF="--reverse-deps"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
G2CONF="${G2CONF} $(use_enable static)"

src_unpack() {

	unpack ${A}
	gnome2_omf_fix

	#GCC 3.4 fix
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.1.12-gcc34.patch

	ln -s ${S}/docs/gal-decl.txt ${S}/docs/gal-2.4-decl.txt
	ln -s ${S}/docs/gal-sections.txt ${S}/docs/gal-2.4-sections.txt

	#USE=doc build fix
	epatch ${FILESDIR}/${PN}-1.99.3-docfix.patch

}
