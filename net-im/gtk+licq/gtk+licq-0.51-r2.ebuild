# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gtk+licq/gtk+licq-0.51-r2.ebuild,v 1.6 2002/07/17 09:08:08 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ interface for Licq, the KDE/QT ICQ client"
SRC_URI="http://gtk.licq.org/download/${P}.tar.gz"
HOMEPAGE="http://gtk.licq.org"

DEPEND="sys-devel/perl 
	=x11-libs/gtk+-1.2*
	>=net-im/licq-1.0.2 
	gnome? ( >=gnome-base/gnome-core-1.4.0.4-r1 )
	spell? ( >=app-text/pspell-0.11.2 )"

RDEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {

	local myconf
	local myprefix

	use gnome || myconf="--disable-gnome"
	use spell || myconf="$myconf --disable-pspell"
	use nls || myconf="${myconf} --disable-nls"

	CXXFLAGS="${CXXFLAGS} `orbit-config --cflags client`"

	econf \
		--with-licq-includes=/usr/include/licq \
		${myconf} || die
	
	emake || die
}

src_install() {
	local myprefix
	myprefix="usr"
	make prefix=${D}/${myprefix} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README
	mkdir -p ${D}/usr/lib/licq
	cd ${D}/usr/lib/licq
	ls	../../../${myprefix}/lib/licq
	ln -s ../../../${myprefix}/lib/licq/* .
}
