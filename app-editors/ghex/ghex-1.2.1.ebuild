# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-editors/ghex/ghex-1.2.1.ebuild,v 1.4 2002/07/25 19:12:43 kabau Exp $

S=${WORKDIR}/${P}

DESCRIPTION="Gnome Hexadecimal editor"

SRC_URI="http://pluton.ijs.si/~jaka/${P}.tar.gz"

HOMEPAGE="http://pluton.ijs.si/~jaka/gnome.html"

RDEPEND="=x11-libs/gtk+-1.2*
	 >=gnome-base/gnome-libs-1.4.1.2-r3
	 >=gnome-base/ORBit-0.5.12-r1
	 >=gnome-base/gnome-print-0.34
	 >=app-text/scrollkeeper-0.2"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {

	local myconf=""
	
	use nls || myconf="$myconf --disable-nls" #default enabled 
	
	./configure 	--host=${CHOST} \
			--prefix=/usr \
			--infodir=/usr/share/info \
			--mandir=/usr/share/man \
			${myconf} || die "Configuration Failed"
	
	emake || die
}

src_install () {
	make 	prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		GNOME_DATA_DIR=${D}/usr/share \
		install || die "Installation Failed"

	dodoc ABOUT-NLS AUTHORS COPYING COPYING-DOCS ChangeLog INSTALL \
		NEWS README
}
