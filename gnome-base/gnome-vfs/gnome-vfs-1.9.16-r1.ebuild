# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-1.9.16-r1.ebuild,v 1.2 2002/06/04 00:38:29 blocke Exp $


# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

S=${WORKDIR}/${P}
DESCRIPTION="the Gnome Virtual Filesystem"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="GPL-2 LGPL-2.1"


RDEPEND=">=dev-libs/glib-2.0.0
	>=gnome-base/gconf-1.1.9
	>=gnome-base/ORBit2-2.3.108
	>=gnome-base/gnome-mime-data-1.0.7
	>=gnome-base/libbonobo-1.115.0
	>=gnome-base/bonobo-activation-0.9.7
	>=sys-devel/gettext-0.10.40
	>=dev-libs/openssl-0.9.5"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.17
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9 )"


src_compile() {
	libtoolize --copy --force
	local myconf
	use doc && myconf="--enable-gtk-doc" || myconf="--disable-gtk-doc"
	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} \
		--enable-debug=yes || die
	emake || die
}

src_install() {
	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make DESTDIR=${D} \
		prefix=/usr \
		sysconfdir=/etc \
		infodir=/usr/share/info \
		mandir=/usr/share/man \
		install || die "installation failed" 

#	make prefix=${D}/usr \
#		sysconfdir=${D}/etc \
#		infodir=${D}/usr/share/info \
#		mandir=${D}/usr/share/man \
#		install || die
	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	dodoc AUTHORS  COPYING* ChangeLog HACKING INSTALL NEWS README TODO 
}




pkg_postinst() {
	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
	echo ">>> updating GConf2 (modemlights)"
	for SCHEMA in system_http_proxy.schemas ; do
		/usr/bin/gconftool-2  --makefile-install-rule \
		/etc/gconf/schemas/${SCHEMA}
	done
}
