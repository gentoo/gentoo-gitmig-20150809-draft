# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Lars S. Jensen <lars@nospam.dk> 
# $Header: /var/cvsroot/gentoo-x86/net-misc/fwbuilder/fwbuilder-1.0.0.ebuild,v 1.1 2002/03/29 23:43:59 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A firewall GUI"
SRC_URI="http://prdownloads.sourceforge.net/fwbuilder/${P}.tar.gz"
HOMEPAGE="http://fwbuilder.sourceforge.net"

DEPEND=">=x11-libs/gtkmm-1.2.5-r1
	>=dev-libs/libxslt-1.0.1
	>=net-libs/libfwbuilder-0.10.0
	media-libs/gdk-pixbuf
	dev-libs/libxml2"

src_compile() {
    local myopts
	
	use static && myopts="${myopts} LDFLAGS=\"-static\""

    ./configure	\
		--prefix=/usr	\
		--host=${CHOST}	\
		|| die

    cp config.h config.h.orig
    sed -e "s:#define HAVE_XMLSAVEFORMATFILE 1://:" config.h.orig > config.h
	
	make ${myopts} || die
}

src_install () {

    make	\
		DESTDIR=${D} \
		install || die

}
