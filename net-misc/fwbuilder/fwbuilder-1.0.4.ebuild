# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /home/cvsroot/gentoo-x86/net-misc/fwbuilder/fwbuilder-1.0.4.ebuild,v 1.0

DESCRIPTION="A firewall GUI"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://fwbuilder.sourceforge.net"
S=${WORKDIR}/${P}

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND=">=x11-libs/gtkmm-1.2.8
	>=dev-libs/libxslt-1.0.7
	>=net-libs/libfwbuilder-0.10.8
	media-libs/gdk-pixbuf
	dev-libs/libxml2"
RDEPEND=$DEPEND

src_compile() {
	local myconf
	use static && myconf="${myconf} --enable-shared=no --enable-static=yes"

	./autogen.sh \
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

src_install() {
	emake DESTDIR=${D} install || die "emake install failed"
}

pkg_postinst() {
	einfo "You may have to install iproute on the machine that"
	einfo "will run the firewall script."
}
