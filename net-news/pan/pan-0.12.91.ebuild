# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-news/pan/pan-0.12.91.ebuild,v 1.1 2002/07/28 17:56:36 stroke Exp $

# Do _NOT_ strip symbols in the build! Need both lines for Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"
# force debug information
CFLAGS="${CFLAGS} -g"
CXXFLAGS="${CXXFLAGS} -g"

DESCRIPTION="A newsreader for the Gnome2 desktop"
SRC_URI="http://pan.rebelbase.com/download/releases/${PV}/SOURCE/${P}.tar.bz2"
HOMEPAGE="http://pan.rebelbase.com"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	>=dev-libs/libxml2-2.4.22
	spell? ( >=app-text/gtkspell-2.0.0 )"

DEPEND="$RDEPEND"

export CONFIG_PROTECT_MASK="/etc/gconf"

src_compile() {

	local myconf

	use nls || myconf="--disable-nls"
	
	if [ -n "`use gtkspell`" ] ; then
		myconf="${myconf} --enable-gtkspell=yes"
	else
		myconf="${myconf} --enable-gtkspell=no"
	fi

	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--localstatedir=/var/lib \
		--enable-debug=yes \
		${myconf} || die "configure failure"

	emake || die "compile failure"
}

src_install() {
	emake prefix=${D}/usr \
		sysconfdir=${D}/etc \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		localstatedir=${D}/var/lib \
		install || die "installation failed"
    
	dodoc ANNOUNCE AUTHORS ChangeLog COPYING CREDITS INSTALL NEWS README TODO
}


