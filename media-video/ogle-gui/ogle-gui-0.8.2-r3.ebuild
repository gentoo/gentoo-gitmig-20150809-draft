# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/ogle-gui/ogle-gui-0.8.2-r3.ebuild,v 1.2 2002/04/27 12:29:18 seemant Exp $

MY_P=${P/-/_}
S=${WORKDIR}/${MY_P}
DESCRIPTION="GUI interface for the Ogle DVD player"
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${MY_P}.tar.gz"
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"

DEPEND=">=media-video/ogle-0.8.2 x11-libs/gtk+ dev-libs/libxml2 sys-devel/bison nls? ( sys-devel/gettext )  gnome-base/libglade"
RDEPEND=$DEPEND

src_compile() {

	local myconf
  
	use nls || myconf="--disable-nls"

	libtoolize --copy --force
	
	# libxml2 hack
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml"

	./configure --prefix=/usr --host=${CHOST} ${myconf}  || die
  	emake || die	

}

src_install() {
	
	make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info docdir=${D}/usr/share/doc/${PF}/html sysconfdir=${D}/etc install || die

	dodoc ABOUT-NLS AUTHORS COPYING INSTALL NEWS README
}
