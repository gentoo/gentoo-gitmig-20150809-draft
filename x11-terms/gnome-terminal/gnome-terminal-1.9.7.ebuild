# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-terms/gnome-terminal/gnome-terminal-1.9.7.ebuild,v 1.2 2002/06/03 13:45:31 stroke Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="The Gnome Terminal"

SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2
         ftp://archive.progeny.com/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"

HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/pango-1.0.0
	>=x11-libs/gtk+-2.0.0
	>=x11-libs/libzvt-1.116.1
	>=gnome-base/libglade-1.99.12-r2
	>=gnome-base/gconf-1.1.8-r1
	>=gnome-base/libgnomeui-1.112.1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"
src_compile() {
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
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
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING README* INSTALL NEWS TODO
}

pkg_postinst() {
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	echo ">>> updating GConf2"
		for SCHEMA in gnome-terminal.schemas ; do
			echo $SCHEMA
			/usr/bin/gconftool-2  --makefile-install-rule \
				/etc/gconf/schemas/${SCHEMA}
		done

}

