# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Spider  <spider@gentoo.org>
# /space/gentoo/cvsroot/gentoo-x86/app-text/scrollkeeper/scrollkeeper-0.2-r2.ebuild,v 1.1 2002/01/14 14:19:25 hallski Exp

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="Scrollkeeper"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/releases/gnome-2.0-desktop-beta2/${P}.tar.bz2"
HOMEPAGE="http://scrollkeeper.sourceforge.net"

RDEPEND=">=dev-libs/libxml-1.8.11
		>=sys-libs/zlib-1.1.3
		>=app-text/docbook-xml-dtd-4.1.2-r2
		>=app-text/docbook-sgml-utils-0.6.6
		>=dev-util/intltool-0.17"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	local  myconf

	if [ -z "`use nls`" ] ; then
		myconf ="--disable-nls"
	fi
	# hack around some to make sure we find the libxml2 includes. odd bug.
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml"
	
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		$myconf || die

	emake || die
}

src_install() {
	cd omf-install
	cp Makefile Makefile.old
	sed -e "s:scrollkeeper-update.*::g" Makefile.old > Makefile
	rm Makefile.old
	cd ${S}
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING* ChangeLog README NEWS
}

pkg_postinst() {
	echo ">>> Rebuilding Scrollkeeper database..."
	scrollkeeper-rebuilddb
	echo ">>> Updating Scrollkeeper database..."
	scrollkeeper-update -v 
}

pkg_postrm() {
	echo ">>> Scrollkeeper ${PV} unmerged, if you removed the package"
	echo "    you might want to clean up /var/lib/scrollkeeper."
}
