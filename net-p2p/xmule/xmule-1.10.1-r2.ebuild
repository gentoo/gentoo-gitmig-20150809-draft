# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/xmule/xmule-1.10.1-r2.ebuild,v 1.2 2005/11/21 22:38:28 mkay Exp $

inherit wxwidgets eutils

DESCRIPTION="wxWidgets based client for the eDonkey/eMule/lMule network"
HOMEPAGE="http://xmule.ws/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2 ZLIB GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

IUSE="nls debug"

DEPEND=">=x11-libs/wxGTK-2.6.2
	nls? ( sys-devel/gettext )
	>=sys-libs/zlib-1.2.1
	!net-p2p/amule
	>=dev-libs/crypto++-5.2.1"

src_unpack() {
	export WX_GTK_VER="2.6"
	need-wxwidgets gtk2

	unpack ${A}
	cd ${S}
	sed -i 's/@datadir@/${DESTDIR}@datadir@/' Makefile.in || die
	sed -i "s:wx-config:${WX_CONFIG}:" src/xmule.make.in || die

	epatch ${FILESDIR}/${P}-crypto-gentoo.patch
	autoreconf
}

src_compile () {
	# replace flags -O3 with -O2 because amule can crash with this 
	# flag, bug #87437
	replace-flags -O3 -O2

	myconf="--with-zlib=/tmp/zlib/
		--with-wx-config=${WX_CONFIG}
		`use_enable debug`
		`use_enable nls`"

	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall mkinstalldirs=${S}/mkinstalldirs DESTDIR=${D} || die
	rm -rf ${D}/var || die
}
