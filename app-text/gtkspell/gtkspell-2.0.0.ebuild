# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/gtkspell/gtkspell-2.0.0.ebuild,v 1.1 2002/07/28 16:48:26 stroke Exp $

DESCRIPTION="GtkSpell is a spell library for GTK2"

SRC_URI="http://gtkspell.sourceforge.net/download/${P}.tar.gz"
# SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gtkspell.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	>=app-text/pspell-0.12.2-r3"

DEPEND="$RDEPEND"

src_compile() {

	local myconf
	use nls || myconf="--disable-nls"

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
    
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}


