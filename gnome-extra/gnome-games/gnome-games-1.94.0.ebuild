# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-1.94.0.ebuild,v 1.1 2002/06/05 22:09:07 spider Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
export CFLAGS="${CFLAGS/-fomit-frame-pointer/} -g"
export CXXFLAGS="${CXXFLAGS/-fomit-frame-pointer/} -g"


S=${WORKDIR}/${P}
DESCRIPTION="Games for the Gnome2 desktop"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=dev-libs/glib-2.0.3
	>=x11-libs/pango-1.0.2
	>=dev-libs/atk-1.0.2
	>=x11-libs/gtk+-2.0.3
	>=x11-libs/libzvt-1.116.0
	=media-libs/freetype-2.0*
	>=dev-libs/libxml2-2.4.22
	>=app-text/scrollkeeper-0.3.4-r1
	>=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1
	>=sys-devel/gettext-0.10.40
	>=dev-util/guile-1.5.4
	>=gnome-base/libglade-1.99.8-r1
	>=gnome-base/gconf-1.1.8-r1
	>=gnome-base/libgnomeui-1.117.1
	>=gnome-base/libgnome-1.117.1
	>=gnome-base/gnome-vfs-1.9.10
	>=gnome-base/ORBit2-2.4.0
	>=gnome-base/bonobo-activation-0.9.9
	>=gnome-base/gnome-panel-1.5.23
	>=gnome-base/libgnomecanvas-1.117.0
	>=gnome-base/libgnomeui-1.117.2-r1"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17
	${RDEPEND}"


		
src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var/lib \
		--disable-guname-capplet \
		--enable-gcolorsel-applet \
		--with-ncurses \
		--enable-debug=yes || die "configure failure"
	emake || die "compile failure"
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var/lib \
		install || die "install failure"
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL

	dodoc AUTHORS COPYING COPYING-DOCS ChangeLog HACKING INSTALL MAINTAINERS NEWS README TODO

	docinto aisleriot
	cd aisleriot
	dodoc AUTHORS ChangeLog TODO
	
	cd ../freecell
	docinto freecell
	dodoc AUTHORS ChangeLog NEWS README TODO

	cd ../gataxx
	docinto gataxx
	dodoc AUTHORS ChangeLog TODO
	
	cd ../glines
	docinto glines
	dodoc AUTHORS ChangeLog NEWS README TODO

	cd ../gnect
	docinto gnect
	dodoc AUTHORS ChangeLog TODO

	cd ../gnibbles
	docinto gnibbles
	dodoc  AUTHORS ChangeLog

	cd ../gnobots2
	docinto gnobots2
	dodoc  AUTHORS README
	
	cd ../gnome-stones
	docinto gnome-stones
	dodoc  ChangeLog README TODO
	
	cd ../gnometris
	docinto gnometris
	dodoc AUTHORS COPYING  ChangeLog TODO

	cd ../gnomine
	docinto gnomine 	
	dodoc AUTHORS ChangeLog README
	
	cd ../gnotravex
	docinto gnotravex
	dodoc AUTHORS  ChangeLog README

	cd ../gnotski
	docinto gnotski
	dodoc AUTHORS ChangeLog README

	cd ../gtali
	docinto gtali
	dodoc AUTHORS ChangeLog INSTALL README TODO

	cd ../iagno
	docinto iagno
	dodoc  AUTHORS ChangeLog

	cd ../mahjongg
	docinto mahjongg
	dodoc ChangeLog NEWS README TODO

	cd ../same-gnome
	docinto same-gnome
	dodoc ChangeLog README TODO

	cd ../xbill
	docinto xbill
	dodoc AUTHORS COPYING ChangeLog NEWS README README.Ports

	cd ..
}

pkg_postinst() {
	echo ">>> Scrollkeeper-update"
		scrollkeeper-update -p /var/lib/scrollkeeper
	echo ">>> updating GConf2"
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	for SCHEMA in freecell.schemas gnect.schemas \
		gnomine.schemas iagno.schemas gataxx.schemas \
		gnometris.schemas  gtali.schemas same-gnome.schemas ; do
		echo $SCHEMA
		/usr/bin/gconftool-2  --makefile-install-rule \
			/etc/gconf/schemas/${SCHEMA}
	done
}	


