# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/aspell/aspell-0.33.7.1-r2.ebuild,v 1.2 2002/08/06 14:50:21 gerk Exp $

inherit libtool

MY_P=${PN}-.33.7.1
S=${WORKDIR}/${MY_P}
DESCRIPTION="A spell checker replacement for ispell"
SRC_URI="http://download.sourceforge.net/aspell/${MY_P}.tar.gz mirror://sourceforge/aspell/aspell-.33-fix2.diff"
HOMEPAGE="http://aspell.sourceforge.net"

DEPEND=">=app-text/pspell-0.12
	>=sys-libs/ncurses-5.2"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc"

#
# These flags a reset here because too much optimisation can cause aspell's
# compilation process to break.  Moreover, these must be set before ./configure
# otherwise it breaks again.  A very fragile build process, really.
#
CXXFLAGS="-O3"
CFLAGS=${CXXFLAGS}

# needed to compile

if [ -e /lib/libc-2.2.5.so ] && [ `gcc -dumpversion` == "2.95.3" ]; then
	if [ ! -f /etc/aspell/aspell.conf ]; then
		mkdir -p /etc/aspell
		touch /etc/aspell/aspell.conf
	fi
	if [ ! -f /root/.aspell.conf ]; then
		touch /root/.aspell.conf
	fi
fi

src_unpack() {

	unpack ${MY_P}.tar.gz
	cd ${S}
	patch -p0 < ${DISTDIR}/aspell-.33-fix2.diff
}

src_compile() {
	# 
	# These two lines are here again to prevent breaking the compilation
	#
	elibtoolize

	./configure \
		--prefix=/usr \
		--sysconfdir=/etc/aspell \
		--host=${CHOST} \
		--enable-doc-dir=/usr/share/doc/${P} || die
	
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	cd ${D}/usr/share/doc/${P}
	dohtml -r man-html
	docinto text
	dodoc man-text
	cd ${S}
	
	dodoc README* TODO

}

