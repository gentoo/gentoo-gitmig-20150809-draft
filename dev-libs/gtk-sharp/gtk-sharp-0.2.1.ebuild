# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}
DESCRIPTION="Gtk# is a C# language binding for the Gtk+ (AKA Gtk2) toolkit."
SRC_URI="mirror://sourceforge/gtk-sharp/${P}.tar.gz"
HOMEPAGE="http://gtk-sharp.sourceforge.net/"

LICENSE="LGPL"
SLOT="0"


DEPEND=">=dev-lang/mono-0.13
		>=x11-libs/gtk+-2.0.2"
RDEPEND="${DEPEND}"
KEYWORDS="x86 -ppc"

src_compile() {
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info || die "./configure failed"
	make || die
}

src_install () {
    # Path for the installation of the libs is hardcoded in the Makefile, so we need to change it
	for i in $(find . -iname Makefile); do cp $i ${i}.orig; sed "s:/usr/lib:${D}/usr/lib:" $i.orig > $i; done
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc HACKING LICENSE README ChangeLog
}
