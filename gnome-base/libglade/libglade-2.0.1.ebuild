# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libglade/libglade-2.0.1.ebuild,v 1.22 2004/11/08 18:18:47 vapier Exp $

inherit gnome2 gnuconfig

DESCRIPTION="GLADE is a interface builder"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2.1"
SLOT="2.0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc sparc x86"
IUSE="doc nls"

RDEPEND=">=dev-libs/glib-2.0.6
	>=x11-libs/gtk+-2.0.6
	>=dev-libs/atk-1.0.3
	>=dev-libs/expat-1.95
	dev-python/pyxml
	>=dev-lang/python-2.0-r7
	>=dev-libs/libxml2-2.4.24
	nls? ( >=sys-devel/gettext-0.10.40 )"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}
	doc? ( dev-util/gtk-doc )
	app-text/docbook-xml-dtd"

src_compile() {
	## allow for configuration on mips systems
	gnuconfig_update
	## patch for xml stuff
	patch -p0 < ${FILESDIR}/Makefile.in.am-xmlcatalog.patch
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
