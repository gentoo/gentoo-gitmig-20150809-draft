# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libglade/libglade-2.4.0.ebuild,v 1.12 2004/11/08 18:18:47 vapier Exp $

# FIXME : catalog stuff
inherit gnome2

DESCRIPTION="GLADE is a interface builder"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="2.0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.4
	>=dev-libs/atk-1
	>=dev-libs/libxml2-2.4.10
	>=dev-lang/python-2.0-r7"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

src_compile() {

	## patch for xml stuff
	patch -p0 < ${FILESDIR}/Makefile.in.am-xmlcatalog.patch

	gnome2_src_compile

}

DOCS="ABOUT-NLS AUTHORS COPYING  ChangeLog INSTALL NEWS README"

src_install() {

	dodir /etc/xml
	gnome2_src_install

}


pkg_postinst() {

	echo ">>> Updating XML catalog"
	/usr/bin/xmlcatalog --noout --add "system" \
		"http://glade.gnome.org/glade-2.0.dtd" \
		/usr/share/xml/libglade/glade-2.0.dtd /etc/xml/catalog
	gnome2_pkg_postinst

}

pkg_postrm() {

	echo ">>> removing entries from the XML catalog"
	/usr/bin/xmlcatalog --noout --del \
		/usr/share/xml/libglade/glade-2.0.dtd /etc/xml/catalog

}
