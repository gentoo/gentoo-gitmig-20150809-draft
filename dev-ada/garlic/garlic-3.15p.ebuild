# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/garlic/garlic-3.15p.ebuild,v 1.3 2003/09/08 07:20:54 msterret Exp $

S="${WORKDIR}/glade-${PV}-src"
DESCRIPTION="The GNAT implementation of the ARM Annex for Distributed Systems."
SRC_URI="http://gd.tuwien.ac.at/languages/ada/gnat/3.15p/glade/glade-${PV}-src.tgz"

HOMEPAGE="http://www.gnat.com/"
LICENSE="GMGPL"
DEPEND="dev-lang/gnat"
RDEPEND=""
SLOT="0"
IUSE=""
KEYWORDS="~x86"

inherit gnat

src_compile() {
	local CFLAGS="${ADACFLAGS} -fPIC"
	local ADACFLAGS="${ADACFLAGS} -fPIC"

#	./configure \
#		--host=${CHOST} \
#		--prefix=/usr \
#		--infodir=/usr/share/info \
#		--mandir=/usr/share/man || die "./configure failed"
	econf || die "./configure failed"
	emake || die

	${ADAC} -shared -Wl,-soname,libgarlic-${PV}.so.1 \
		-o Garlic/libgarlic-${PV}.so.1 Garlic/*.o -lc
}

src_install () {
	make prefix=${D}/usr \
		GARLIC=${D}/usr/lib/ada/adainclude/garlic install || die

	dodoc COPYING INSTALL NEWS README

	insinto /usr/lib/ada/adalib/garlic
	chmod 0755 Garlic/libgarlic-${PV}.so.1
	doins Garlic/libgarlic-${PV}.so.1
	cd ${D}/usr/lib/ada/adalib/garlic/
	ln -s libgarlic-${PV}.so.1 libgarlic-${PV}.so
	ln -s libgarlic-${PV}.so libgarlic.so
	cd ${S}

	# And of course, as usualy make install does not conform to GNAE
	mv ${D}/usr/lib/ada/adainclude/garlic/*.ali \
		${D}/usr/lib/ada/adalib/garlic/
	mv ${D}/usr/lib/ada/adainclude/garlic/lib*.a \
		${D}/usr/lib/ada/adalib/garlic/

	#install examples
	cp -r Examples ${D}/usr/share/doc/${PF}/
}
