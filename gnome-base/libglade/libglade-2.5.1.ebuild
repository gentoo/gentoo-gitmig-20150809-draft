# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libglade/libglade-2.5.1.ebuild,v 1.8 2005/08/23 01:33:29 agriffis Exp $

# FIXME : catalog stuff
inherit gnome2 eutils

DESCRIPTION="GLADE is a interface builder"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="2.0"
KEYWORDS="~alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.5
	>=x11-libs/gtk+-2.5
	>=dev-libs/atk-1.9
	>=dev-libs/libxml2-2.4.10
	>=dev-lang/python-2.0-r7"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="ABOUT-NLS AUTHORS ChangeLog NEWS README"

src_compile() {

	cd ${S}
	# patch to stop make install installing the xml catalog
	# because we do it ourselves in postinst()
	epatch ${FILESDIR}/Makefile.in.am-2.4.2-xmlcatalog.patch

	gnome2_src_compile

}

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
