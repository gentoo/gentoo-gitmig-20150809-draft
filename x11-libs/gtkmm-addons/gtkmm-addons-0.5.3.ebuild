# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

MY_P="`echo ${P} |sed -e 's/-//' -e 's/g/G/' -e 's/a/A/'`"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Gtk--Addons - a set of extensions to gtk[--]."
SRC_URI="http://home.wtal.de/petig/Gtk/${MY_P}.tar.gz"
HOMEPAGE="http://home.wtal.de/petig/Gtk/"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="=x11-libs/gtk+-1.2*
	>=x11-libs/gtkmm-1.2.5-r1"


src_compile() {

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info || die

	emake || die
}

src_install() {

	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     install || die

	dodoc AUTHORS COPYING COPYING.LIB ChangeLog INSTALL NEWS README TODO
}
