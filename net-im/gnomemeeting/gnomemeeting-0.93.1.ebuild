# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomemeeting/gnomemeeting-0.93.1.ebuild,v 1.3 2002/09/11 15:25:22 raker Exp $

inherit gnome2

S="${WORKDIR}/GnomeMeeting-${PV}"
SRC_URI="http://www.gnomemeeting.org/downloads/latest/sources/GnomeMeeting-${PV}.tar.gz"
HOMEPAGE="http://www.gnomemeeting.org"
DESCRIPTION="Gnome NetMeeting client"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -sparc64"

RDEPEND="net-libs/openh323
	>=dev-libs/glib-2.0.3
	>=x11-libs/gtk+-2.0.5
	>=sys-devel/autoconf-2.52
	>=dev-libs/pwlib-1.2.19
	>=net-nds/openldap-2.0.21
	>=dev-libs/libIDL-0.8.0
	>=net-libs/linc-0.5.0-r2
	>=gnome-base/gnome-2.0.1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17"

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
		--host=${CHOST} || die

	#manually disable installation of schemas
	cp Makefile Makefile.orig
	sed -e "s/^install-data-local: install-schemas/install-data-local:/g" Makefile.orig > Makefile || die
	make || die
}

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS FAQ TODO"
G2CONF="${G2CONF} --enable-platform-gnome-2"
SCHEMAS="gnomemeeting.schema"
	
															
