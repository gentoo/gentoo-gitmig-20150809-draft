# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnophone/gnophone-0.2.4-r1.ebuild,v 1.2 2004/02/17 21:14:48 humpback Exp $

DESCRIPTION="internet telephone"
HOMEPAGE="http://www.gnophone.com/"
SRC_URI="ftp://ftp.gnophone.com/pub/gnophone/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

IUSE=""
DEPEND="media-sound/gsm
	net-libs/iax
	media-sound/sox
	mozilla? ( net-www/mozilla )
	esd? ( media-sound/esound )
	x11-libs/gtk+
	media-libs/gdk-pixbuf
	dev-libs/glib
	x11-base/xfree
	media-libs/imlib
	virtual/glibc"


D_PREFIX=/usr


src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-raw2h.c.patch
	epatch ${FILESDIR}/${P}-mkdtmf.c.patch
}

src_compile() {
	local myconf

	use mozilla \
		&& myconf="${myconf}
			--with-mozilla-home=/usr/lib/mozilla
			--with-mozilla-lib=/usr/lib/mozilla
			--with-mozilla-include=/usr/lib/mozilla/include" \
		|| myconf="${myconf} --disable-mozilla"
	use esd \
		|| myconf="${myconf} --disable-esd"

	./configure ${myconf} \
		--prefix=${D_PREFIX} --enable-upgrade --disable-zaptel \
		|| die "./configure failed"

	pushd ${S}/sounds && make && popd # -j2 breaks the sound build

	emake || die
}

src_install () {
	make prefix=${D}/${D_PREFIX} install
	dodoc NEWS COPYING AUTHORS README
}
