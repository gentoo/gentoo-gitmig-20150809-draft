# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/screem/screem-0.4.1-r2.ebuild,v 1.12 2004/02/17 00:45:29 mr_bones_ Exp $

IUSE="gtkhtml ssl nls"

S=${WORKDIR}/${P}
DESCRIPTION="SCREEM (Site CReating and Editing EnvironmenMent) is an
integrated environment of the creation and maintenance of websites and
pages"
SRC_URI="http://ftp1.sourceforge.net/screem/${P}.tar.gz"
HOMEPAGE="http://www.screem.org"
KEYWORDS="x86 sparc "
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	>=dev-libs/libxml-1.8.15
	>=media-libs/gdk-pixbuf-0.11.0-r1
	<gnome-base/libglade-2
	>=gnome-base/gnome-vfs-1.0.2-r1
	ssl? ( dev-libs/openssl )
	gtkhtml? ( >=gnome-extra/gtkhtml-0.14.0-r1 )
	nls? ( sys-devel/gettext )"

src_compile() {
	libtoolize --copy --force

	local myopts=""
	if [ -z "`use nls`" ]
	then
		myopts="--disable-nls"
	fi
	if [ "`use ssl`" ]
	then
		myopts="$myopts --with-ssl"
	fi

	cp ${FILESDIR}/Makefile.in intl/Makefile.in

	CFLAGS="${CFLAGS} `gdk-pixbuf-config --cflags` "
	CFLAGS="${CFLAGS} `gnome-config --cflags libglade`"

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --sysconfdir=/etc \
		    --localstatedir=/var/lib \
		    --with-gnomevfs \
		    ${myopts} || die

	if [ "`use ssl`" ]
	then
		cd ${S}/plugins/uploadWizard
		cp Makefile Makefile.orig
		sed -e "s:uploadWizard_la_LIBADD =:uploadWizard_la_LIBADD = -lssl:" \
			-e "s:uploadWizard_la_DEPENDENCIES =:uploadWizard_la_DEPENDENCIES = -lssl:" \
			Makefile.orig > Makefile
		cd ${S}
	fi

	emake || die
}

src_install () {
	make prefix=${D}/usr \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/lib \
		 Applicationsdir=${D}/usr/share/gnome/apps/Development \
		 gnewdir=${D}/usr/share/mc/templates \
		 Mimedir=${D}/usr/share/mime-info \
	     install || die

	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog DEPENDS FAQ INSTALL
	dodoc NEWS README TODO
}

