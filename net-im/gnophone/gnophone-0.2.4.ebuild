# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnophone/gnophone-0.2.4.ebuild,v 1.10 2005/03/23 16:18:32 seemant Exp $

IUSE="esd mozilla"

DESCRIPTION="internet telephone"
HOMEPAGE="http://www.gnophone.com/"
LICENSE="GPL-2"
DEPEND="media-sound/gsm
	net-libs/iax
	media-sound/sox
	mozilla? ( www-client/mozilla )
	esd? ( media-sound/esound )
	x11-libs/gtk+
	media-libs/gdk-pixbuf
	dev-libs/glib
	media-libs/imlib
	virtual/libc"
RDEPEND="media-sound/gsm
	net-libs/iax
	media-sound/sox
	mozilla? ( www-client/mozilla )
	esd? ( media-sound/esound )
	x11-libs/gtk+
	media-libs/gdk-pixbuf
	dev-libs/glib
	media-libs/imlib
	virtual/libc"
SLOT="0"
SRC_URI="ftp://ftp.gnophone.com/pub/gnophone/${P}.tar.gz"

D_PREFIX=/usr

KEYWORDS="x86"

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
