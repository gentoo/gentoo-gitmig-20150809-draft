# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/xmule/xmule-1.8.2-r3.ebuild,v 1.7 2004/08/16 16:57:18 pythonhead Exp $

inherit eutils wxwidgets

MY_P=${P}c
S=${WORKDIR}/${PN}

DESCRIPTION="wxWidgets based client for the eDonkey/eMule/lMule network"
HOMEPAGE="http://xmule.ws/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz
	http://dev.gentoo.org/~squinky86/files/${P}-gcc34.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"

IUSE="nls gtk2"

DEPEND=">=x11-libs/wxGTK-2.4.2-r2
	nls? ( sys-devel/gettext )
	>=sys-libs/zlib-1.2.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's/@datadir@/${DESTDIR}@datadir@/' Makefile.in
	epatch ${DISTDIR}/${P}-gcc34.patch
}

src_compile () {
	local myconf=

	if ! use gtk2 ; then
		need-wxwidgets gtk
	else
		need-wxwidgets gtk2
	fi

	use nls \
		|| myconf="${myconf} --disable-nls"

	myconf="${myconf} --with-zlib=/tmp/zlib/"

	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall mkinstalldirs=${S}/mkinstalldirs DESTDIR=${D} || die
	dodir /usr/share/xmule
	insinto /usr/share/xmule
	doins src/resource/*
	mv ${D}/usr/bin/xmule ${D}/usr/bin/xmule-bin
	mv ${D}/var/tmp/portage/${PF}/image/usr/share/locale/* ${D}/usr/share/locale/
	rm -rf ${D}/var
	exeinto /usr/bin
	newexe ${FILESDIR}/xmule.sh xmule
}
