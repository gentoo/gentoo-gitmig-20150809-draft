# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkDPS/gtkDPS-0.3.4.ebuild,v 1.4 2004/03/21 15:09:48 dholm Exp $

inherit gnuconfig

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Set of functions, objects and widgets to use DPS easily with GTK"
SRC_URI="ftp://ftp.gyve.org/pub/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gyve.org/gtkDPS/"
LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc alpha ~ppc"

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
	>=app-text/dgs-0.5.9.1"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	if use alpha; then
		gnuconfig_update || die "gnuconfig_update failed"
	fi

	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi

	./configure --prefix=/usr --host=${CHOST} \
		--with-x --with-dps $myconf || die
	make || die

}

src_install () {

	make prefix=${D}/usr install || die
	dodoc COPYING* ChangeLog GTKDPS-VERSION HACKING NEWS README TODO
}
