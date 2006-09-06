# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/eog/eog-0.6-r4.ebuild,v 1.14 2006/09/06 05:35:20 kumba Exp $

GNOME_TARBALL_SUFFIX="gz"
inherit gnome.org eutils

IUSE="nls png jpeg"

DESCRIPTION="Eye of GNOME"
HOMEPAGE="http://www.gnome.org/gnome-office/eog.shtml"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="ppc ~sparc x86"

DEPEND=">=gnome-base/gconf-1.0.4-r2
	>=gnome-base/bonobo-1.0.9-r1
	>=gnome-base/gnome-print-0.25i
	=gnome-base/libglade-0*
	>=gnome-base/oaf-0.6.2
	>=media-libs/gdk-pixbuf-0.16.0
	=dev-libs/glib-1.2*
	jpeg? ( media-libs/jpeg )
	png? ( 	media-libs/libpng
			sys-libs/zlib )"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext
	>=dev-util/intltool-0.11 )"

src_unpack() {

	unpack ${A}

	cd ${S}/po
	# Fix the makefile to use DESTDIR for locale dirs as well
	epatch ${FILESDIR}/${P}-version_locale_dirs.patch

}

src_compile() {

	econf `use_enable nls`  || die
	emake || die
}

src_install() {

	make DESTDIR=${D} \
		GCONF_CONFIG_SOURCE="xml::${D}/etc/gconf/gconf.xml.defaults" \
		install || die

	dodoc AUTHORS COPYING DEPENDS ChangeLog HACKING NEWS README \
		TODO MAINTAINERS
}
