# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Spider  <spider@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/dev-libs/glib/glib-1.3.14.ebuild,v 1.1 2002/02/20 22:11:06 gbevin Exp

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="GLADE is a interface builder"
SRC_URI="http://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/libglade/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="2.0"
DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-libs/glib-2.0.0
	>=x11-libs/gtk+-2.0.0
	>=dev-libs/atk-1.0.0
	>=dev-libs/expat-1.95.1-r1
	>=dev-lang/python-2.0-r7
	>=sys-devel/gettext-0.10.40
	>=dev-libs/libxml2-2.4.17"

src_compile() {
	local myconf
	 patch -p0 < ${FILESDIR}/Makefile.in-0.patch
	./configure --host=${CHOST} \
			--prefix=/usr \
			--sysconfdir=/etc \
			--infodir=/usr/share/info \
			--mandir=/usr/share/man \
			--enable-debug=yes || die
	
	emake || die
}

src_install() {
	dodir /etc/xml
	make \
		prefix=${D}/usr \
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

	




