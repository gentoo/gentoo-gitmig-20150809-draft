# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-wm/metacity/metacity-2.3.987.ebuild,v 1.3 2002/08/02 17:53:02 seemant Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"


S=${WORKDIR}/${P}
DESCRIPTION="Small gtk2 WindowManager"
SRC_URI="http://people.redhat.com/~hp/metacity/${P}.tar.gz"
HOMEPAGE="http://people.redhat.com/~hp/metacity/"
SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND=">=dev-libs/glib-2.0.3
	>=x11-libs/pango-1.0.2
	>=x11-libs/gtk+-2.0.3
	>=gnome-base/gconf-1.1.11
	>=net-libs/linc-0.1.20
	>=gnome-base/ORBit2-2.4.0"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--enable-platform-gnome-2 \
		--enable-debug=yes || die
	emake || die
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
    
	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README
}

pkg_postinst() {
	echo ">>> updating GConf2"
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	for SCHEMA in metacity.schemas ; do
	        echo $SCHEMA
	        /usr/bin/gconftool-2  --makefile-install-rule \
	                /etc/gconf/schemas/${SCHEMA}
	done
}       

