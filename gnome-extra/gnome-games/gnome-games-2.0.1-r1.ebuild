# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-games/gnome-games-2.0.1-r1.ebuild,v 1.2 2002/07/25 03:38:18 spider Exp $

inherit debug
inherit libtool

S=${WORKDIR}/${P}
DESCRIPTION="Games for the Gnome2 desktop"
SRC_URI="mirror://gnome/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="GPL-2"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/pango-1.0.3
	>=dev-libs/atk-1.0.2
	>=x11-libs/gtk+-2.0.5
	>=x11-libs/libzvt-2.0.0
	=media-libs/freetype-2.0*
	>=dev-libs/libxml2-2.4.22
	>=app-text/scrollkeeper-0.3.4-r1
	>=sys-libs/ncurses-5.2
	>=sys-libs/readline-4.1
	>=sys-devel/gettext-0.10.40
	>=gnome-base/libglade-2.0.0
	>=gnome-base/gconf-1.2.0
	>=gnome-base/gnome-vfs-2.0.0
	>=gnome-base/ORBit2-2.4.0
	>=gnome-base/bonobo-activation-1.0.0
	>=gnome-base/gnome-panel-2.0.0
	>=gnome-base/libgnome-2.0.1
	>=gnome-base/libgnomecanvas-2.0.1
	>=gnome-base/libgnomeui-2.0.1"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17
	${RDEPEND}"


		
src_compile() {
	elibtoolize
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var/lib \
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
	for SCHEMA in same-gnome.schemas mahjongg.schemas \
		iagno.schemas gtali.schemas gnomine.schemas \
		gnometris.schemas gnect.schemas \
		gataxx.schemas freecell.schemas ; do 
		echo $SCHEMA
		/usr/bin/gconftool-2  --makefile-install-rule \
			/etc/gconf/schemas/${SCHEMA}
	done
}	


