# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/fwbuilder/fwbuilder-1.0.3.ebuild,v 1.3 2002/08/14 12:08:07 murphy Exp $

DESCRIPTION="A firewall GUI"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
KEYWORDS="x86 sparc sparc64"
LICENSE="GPL-2"
SLOT="0"
HOMEPAGE="http://fwbuilder.sourceforge.net"

DEPEND=">=x11-libs/gtkmm-1.2.5-r1
	>=dev-libs/libxslt-1.0.1
	>=net-libs/libfwbuilder-0.10.7
	media-libs/gdk-pixbuf
	dev-libs/libxml2"

src_compile() {
	local myconf
	use static && myconf="${myconf} --enable-shared=no --enable-static=yes"

	./configure \
		--prefix=/usr \
		--host=${CHOST}	|| die "./configure failed"

	cp config.h config.h.orig
	sed -e "s:#define HAVE_XMLSAVEFORMATFILE 1://:" config.h.orig > config.h
	
	if [ "`use static`" ]
	then
		emake LDFLAGS="-static" || die "emake LDFLAGS failed"
	else
		emake || die "emake failed"
	fi
}

src_install () {
	emake DESTDIR=${D} install || die "emake install failed"
}
