# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/aspell/aspell-0.50_pre20020811.ebuild,v 1.3 2002/08/14 17:02:41 seemant Exp $

inherit libtool

MY_P=${P/_pre/-}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A spell checker replacement for ispell"
SRC_URI="http://savannah.gnu.org/download/aspell/${MY_P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/aspell/index.html"

DEPEND=">=sys-libs/ncurses-5.2"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc"

#
# These flags a reset here because too much optimisation can cause aspell's
# compilation process to break.  Moreover, these must be set before ./configure
# otherwise it breaks again.  A very fragile build process, really.
#
CXXFLAGS="-O2"
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

src_compile() {
	elibtoolize

	econf \
		--disable-static \
		--sysconfdir=/etc/aspell \
		--enable-docdir=/usr/share/doc/${PF} || die
	
	emake || die

}

src_install () {

	make DESTDIR=${D} install || die
	cd ${D}/usr/share/doc/${P}
	dohtml -r man-html
	docinto text
	dodoc man-text
	cd ${S}
	
	dosym /usr/lib/libpspell.so.15 /usr/lib/libpspell.so
	
	dodoc README* TODO

}
