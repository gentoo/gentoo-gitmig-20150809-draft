# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/etherape/etherape-0.8.2-r1.ebuild,v 1.1 2002/07/15 07:22:47 mkennedy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A graphical network monitor for Unix modeled after etherman"
SRC_URI="mirror://sourceforge/etherape/${P}.tar.gz"
HOMEPAGE="http://etherape.sourceforge.net/"

DEPEND="	=x11-libs/gtk+-1.2*
		>=gnome-base/gnome-libs-1.4.1.2-r1
		>=net-libs/libpcap-0.6.1
		>=gnome-base/libglade-0.17-r3 "

RDEPEND="${DEPEND}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_unpack() {
	unpack ${A}
	cd ${S} 
	patch -p1 <${FILESDIR}/etherape-0.8.2-gcc3-gentoo.patch
}

src_compile() {

	local myconf

	use nls  ||  myconf="--disable-nls"

	# configure script not listening to libglade-config?
	CFLAGS="${CFLAGS} `/usr/bin/libglade-config --cflags`"

  	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    ${myconf} || die

	emake || die
}

src_install() {

  	make prefix=${D}/usr sysconfdir=${D}/etc install || die

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog FAQ INSTALL NEWS OVERVIEW
	dodoc README README.bugs README.help README.thanks TODO
}

