# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkmm-addons/gtkmm-addons-0.5.3.ebuild,v 1.14 2003/06/12 22:16:59 msterret Exp $

MY_P="`echo ${P} |sed -e 's/-//' -e 's/g/G/' -e 's/a/A/'`"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Gtk--Addons - a set of extensions to gtk[--]."
SRC_URI="http://home.wtal.de/petig/Gtk/${MY_P}.tar.gz"
HOMEPAGE="http://home.wtal.de/petig/Gtk/"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND="=x11-libs/gtk+-1.2*
	>=x11-libs/gtkmm-1.2.5-r1"


src_compile() {

	./configure --host=${CHOST} \
		    --prefix=/usr \
		    --mandir=/usr/share/man \
		    --infodir=/usr/share/info || die

	emake || die
}

src_install() {

	make prefix=${D}/usr \
	     mandir=${D}/usr/share/man \
	     infodir=${D}/usr/share/info \
	     install || die

	dodoc AUTHORS COPYING COPYING.LIB ChangeLog INSTALL NEWS README TODO
}
