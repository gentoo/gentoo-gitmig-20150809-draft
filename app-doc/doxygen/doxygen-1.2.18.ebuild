# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/doxygen/doxygen-1.2.18.ebuild,v 1.13 2004/01/26 16:13:51 weeve Exp $

DESCRIPTION="Doxygen is a documentation system for C++, Java, IDL (Corba, Microsoft and KDE-DCOP flavors) and C."
HOMEPAGE="http://www.doxygen.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

RDEPEND="qt? ( x11-libs/qt )
	media-gfx/graphviz"
DEPEND="$RDEPEND"

S=${WORKDIR}/${P}
SRC_URI="ftp://ftp.stack.nl/pub/users/dimitri/${P}.src.tar.gz"

src_unpack() {

	unpack ${A}

# doxygen's setup doesn't play nicely with our CFLAGS, etc.  Make it.
	cd ${S}/tmake/lib/linux-g++
	sed -i -e "s:^TMAKE_CFLAGS\(\t*\)= .*$:TMAKE_CFLAGS\1= ${CFLAGS}:" \
		-e "s:^TMAKE_CFLAGS_RELEASE\(\t*\)= .*$:TMAKE_CFLAGS_RELEASE\1= ${CFLAGS}:" \
		-e "s:^TMAKE_CXXFLAGS\(\t*\)= .*$:TMAKE_CXXFLAGS\1= ${CXXFLAGS}:" \
	tmake.conf
}

src_compile()
{

	use qt && CONFIGURE_OPTIONS="--with-doxywizard"

	./configure  --install install --prefix ${D}/usr ${CONFIGURE_OPTIONS} || die
	make all || die

}

src_install()
{

	make install || die
	dodoc README VERSION LICENSE LANGUAGE.HOWTO PLATFORMS

}
