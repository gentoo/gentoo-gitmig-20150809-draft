# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/asis/asis-3.15p.ebuild,v 1.2 2003/09/08 07:20:54 msterret Exp $

inherit gnat

S="${WORKDIR}/${P}-src"
DESCRIPTION="The Ada Semantic Interface Specification queries and services provide a consistent interface to information within the Ada Program Library created at compile time."
SRC_URI="http://gd.tuwien.ac.at/languages/ada/gnat/3.15p/asis/${P}-src.tgz"
HOMEPAGE="http://www.gnat.com/"

LICENSE="GMGPL"
DEPEND="dev-lang/gnat"
RDEPEND=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_unpack() {
	unpack "${P}-src.tgz"
	cd "${S}"
	patch -p1 < "${FILESDIR}/${P}.diff"
}

src_compile() {
	emake -C obj libasis.a CFLAGS="${ADACFLAGS} -fPIC" \
		CC=gnatgcc RM="rm -f" || die "Failed while compiling ASIS"
	emake -C documentation || die "Failed while compiling documentation"

	# Build the shared library
	${ADAC} -shared -Wl,-soname,libasis-${PV}.so.1 \
		-o obj/libasis-${PV}.so.1 obj/*.o -lc

	local MAKEFLAGS="-cargs ${ADACFLAGS} -I../../asis -I../../gnat -I../../obj -largs -L../../obj ../../obj/libasis.a"
	cd "${S}/tools/asistant"
	${ADAMAKE} asistant-driver -o asistant ${MAKEFLAGS}
	cd "${S}/tools/gnatelim"
	${ADAMAKE} gnatelim-driver -o gnatelim ${MAKEFLAGS}
	cd "${S}/tools/gnatstub"
	${ADAMAKE} gnatstub-driver -o gnatstub ${MAKEFLAGS}
	cd "${S}"
}

src_install () {
	dodoc documentation/*.{html,ps,txt}
	doinfo documentation/*.info

	insinto /usr/lib/ada/adalib/${PN}
	# Install the dynamic library
	chmod 0755 obj/libasis-${PV}.so.1
	doins obj/libasis-${PV}.so.1

	# Install the intermediate compiler information files
	doins obj/*.ali
	chmod 0644 obj/libasis.a

	# Install the static library
	newins obj/libasis.a libasis-${PV}.a

	#make local symlinks, as done usually in libs
	cd ${D}/usr/lib/ada/adalib/${PN}/
	ln -s libasis-${PV}.so.1 libasis-${PV}.so
	ln -s libasis-${PV}.so libasis.so
	ln -s libasis-${PV}.a libasis.a
	cd ${S}
#	dosym /usr/lib/ada/adalib/asis/libasis-${PV}.so.1 \
#		/usr/lib/ada/adalib/asis/libasis-${PV}.so
#	dosym /usr/lib/ada/adalib/asis/libasis-${PV}.so \
#		/usr/lib/ada/adalib/asis/libasis.so
#	dosym /usr/lib/ada/adalib/asis/libasis-${PV}.a \
#		/usr/lib/ada/adalib/asis/libasis.a

	#headers and binaries
	insinto /usr/lib/ada/adainclude/${PN}
	doins gnat/*.ad[sb]
	doins asis/*.ad[sb]

	insinto /usr/bin
	dobin tools/asistant/asistant
	dobin tools/gnatelim/gnatelim
	dobin tools/gnatstub/gnatstub
}

