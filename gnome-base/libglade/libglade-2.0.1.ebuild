# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libglade/libglade-2.0.1.ebuild,v 1.9 2003/04/13 14:38:59 seemant Exp $

IUSE="doc nls"


inherit gnome2

LICENSE="LGPL-2.1"

S=${WORKDIR}/${P}
DESCRIPTION="GLADE is a interface builder"
SRC_URI="mirror://gnome/2.0.1/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
KEYWORDS="x86 ppc sparc alpha"
SLOT="2.0"

RDEPEND=">=dev-libs/glib-2.0.6
	>=x11-libs/gtk+-2.0.6
	>=dev-libs/atk-1.0.3
	>=dev-libs/expat-1.95
	dev-python/PyXML
	>=dev-lang/python-2.0-r7
	>=dev-libs/libxml2-2.4.24
	nls? ( >=sys-devel/gettext-0.10.40 )"
	
DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}
	doc? ( dev-util/gtk-doc )
	app-text/docbook-xml-dtd"
	
src_compile() {
	## patch for xml stuff
	patch -p0 < ${FILESDIR}/Makefile.in-0.patch
	gnome2_src_configure	
	emake || die "die a horrible death"
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
