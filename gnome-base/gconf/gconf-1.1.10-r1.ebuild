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

MY_PN=GConf

S=${WORKDIR}/${MY_PN}-${PV}
DESCRIPTION="Gnome Configuration System and Daemon"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/pre-gnome2/sources/${MY_PN}/${MY_PN}-${PV}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

RDEPEND=">=dev-libs/glib-2.0.1
		>=gnome-base/ORBit2-2.3.106
		>=dev-libs/libxml2-2.4.17
		>=net-libs/linc-0.1.19"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"
src_compile() {
	local myconf

	./configure --host=${CHOST} \
		    --prefix=/usr \
			--sysconfdir=/etc \
		    --infodir=/usr/share/info \
		    --mandir=/usr/share/man \
		    --localstatedir=/var/lib \
			--enable-debug=yes || die "configure failed" 

	emake || die "emake failed" 
}

src_install() {
#	export GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL="1"
	make prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var/lib \
		install || die "install failed" 
#	unset GCONF_DISABLE_MAKEFILE_SCHEMA_INSTALL
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING README* INSTALL NEWS  TODO
}



#pkg_postinst() {
#	export GCONF_CONFIG_SOURCE=`gconftool-2 --get-default-source`
#	for SCHEMA in desktop.schemas; do
#		/usr/bin/gconftool-2  --makefile-install-rule \
#			/etc/gconf/schemas/${SCHEMA}
#	done
#	
#}
	


