# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/screem/screem-0.4.1-r1.ebuild,v 1.5 2002/07/14 20:25:23 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="SCREEM (Site CReating and Editing EnvironmenMent) is an
integrated environment of the creation and maintenance of websites and
pages"
SRC_URI="http://ftp1.sourceforge.net/screem/${P}.tar.gz"
HOMEPAGE="http://www.screem.org"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	>=dev-libs/libxml-1.8.15
	>=gnome-base/libglade-0.17-r1
	>=media-libs/gdk-pixbuf-0.11.0-r1
	>=gnome-base/gnome-vfs-1.0.2-r1
	ssl? ( dev-libs/openssl )
	gtkhtml? ( >=gnome-extra/gtkhtml-0.14.0-r1 )
	nls? ( sys-devel/gettext )"

src_compile() {
	local myopts

	if [ -z "`use nls`" ]
	then
		myopts="--disable-nls"
	fi

#	if [ "`use ssl`" ]
#	then
#		myopts="$myopts --with-ssl"
#	fi

	cp ${FILESDIR}/Makefile.in intl/Makefile.in

	CFLAGS="${CFLAGS} `gnome-config --cflags libglade`"

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    --with-gnomevfs					\
		    ${myopts} || die

	emake || die
}

src_install () {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog DEPENDS FAQ INSTALL
	dodoc NEWS README TODO
}

