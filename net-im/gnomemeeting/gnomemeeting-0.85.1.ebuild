# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomemeeting/gnomemeeting-0.85.1.ebuild,v 1.4 2002/07/17 09:08:08 seemant Exp $

S="${WORKDIR}/GnomeMeeting-${PV}"
SRC_URI="http://www.gnomemeeting.org/downloads/latest/sources/GnomeMeeting-${PV}.tar.gz"
HOMEPAGE="http://www.gnomemeeting.org"
DESCRIPTION="Gnome NetMeeting client"

DEPEND="net-libs/openh323
	>=gnome-base/gnome-libs-1.4.1.4
	>=dev-libs/pwlib-1.2.12-r3
	>=media-libs/gdk-pixbuf-0.16.0
	>=dev-libs/openssl-0.9.6c
	>=gnome-base/gconf-1.0.8
	>=net-nds/openldap-2.0.21
	=x11-libs/gtk+-1.2*"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"


src_compile() {

	cd ${S}
	export PWLIBDIR=/usr/share/pwlib
	export OPENH323DIR=/usr/share/openh323
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--with-ptlib-includes=$PWLIBDIR/include/ptlib \
		--with-ptlib-libs=/usr/lib \
		--with-openh323-includes=$OPENH323DIR/include \
		--with-openh323-libs=/usr/lib \
		--disable-install-schemas \
		--host=${CHOST} || die
	make || die

}

src_install() {

	make DESTDIR=${D} install || die
}

pkg_postinst() {
	# This is from the devhelp ebuild...
	# Fix gconf permissions
	killall gconfd-1 2>/dev/null >/dev/null
	chmod o+rX /etc/gconf -R
	# Install schemas
	gconftool-1 --shutdown
	SOURCE=xml::/etc/gconf/gconf.xml.defaults
	GCONF_CONFIG_SOURCE=$SOURCE \
		gconftool-1 --makefile-install-rule \
		/etc/gconf/schemas/${PN}.schema \
		# 2>/dev/null >/dev/null || exit 1
	assert "gconftool-1 execution failed"
}	
															
