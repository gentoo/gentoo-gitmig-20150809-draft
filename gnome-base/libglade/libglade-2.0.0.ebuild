# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libglade/libglade-2.0.0.ebuild,v 1.10 2003/08/29 20:28:25 liquidx Exp $

inherit flag-o-matic
# Do _NOT_ strip symbols in the build!
RESTRICT="nostrip"
append-flags -g

DESCRIPTION="GLADE is a interface builder"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="http://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="2.0"
KEYWORDS="x86 ppc sparc"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.0.3
	>=x11-libs/gtk+-2.0.3
	>=dev-libs/atk-1.0.0
	>=dev-libs/expat-1.95
	dev-python/pyxml
	>=dev-lang/python-2.0-r7
	>=sys-devel/gettext-0.10.40
	>=dev-libs/libxml2-2.4.17"
DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}
	doc? ( dev-util/gtk-doc )
	app-text/docbook-xml-dtd"
	
src_compile() {
	local myconf
	use doc && myconf="--enable-gtk-doc" || myconf="--disable-gtk-doc"
	
	## patch for xml stuff
	patch -p0 < ${FILESDIR}/Makefile.in-0.patch
	libtoolize --copy --force
	./configure --host=${CHOST} \
			--prefix=/usr \
			--sysconfdir=/etc \
			--infodir=/usr/share/info \
			--mandir=/usr/share/man \
			--enable-debug=yes ${myconf} || die "configure this"
	
	emake || die "die a horrible death"
}

src_install() {
	dodir /etc/xml
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
    
 	dodoc ABOUT-NLS AUTHORS COPYING  ChangeLog INSTALL NEWS README 
}

pkg_postinst() {
	echo ">>> Updating XML catalog"
	/usr/bin/xmlcatalog --noout --add "system" \
		"http://glade.gnome.org/glade-2.0.dtd" \
		/usr/share/xml/libglade/glade-2.0.dtd /etc/xml/catalog	
}

pkg_postrm() {
	echo ">>> removing entries from the XML catalog"
	/usr/bin/xmlcatalog --noout --del \
		/usr/share/xml/libglade/glade-2.0.dtd /etc/xml/catalog
}
