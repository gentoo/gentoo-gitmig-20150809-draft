# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/jigdo/jigdo-0.7.0.ebuild,v 1.2 2003/09/05 22:01:48 msterret Exp $

inherit eutils

DESCRIPTION="Jigsaw Download, or short jigdo, is a tool designed to ease the distribution of very large files over the internet, for example CD or DVD images."
HOMEPAGE="http://home.in.tum.de/~atterer/jigdo/"
SRC_URI="http://home.in.tum.de/~atterer/jigdo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"

IUSE="gtk nls"

DEPEND="gtk? ( >=gtk+-2.0.6 )
	nls? ( sys-devel/gettext )
	>=libwww-5.3.2"

src_compile() {
local myconf

	use nls || myconf="--disable-nls"
	use gtk || myconf="--without-libdb --without-gui"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man $myconf \
		--datadir=/usr/share || die "./configure failed"

	# Patch the Makefile so that when jidgo is installed, jigdo-lite has
	# the correct path to the debian mirrors file.
	epatch ${FILESDIR}/makefile.patch

	emake || die
}

src_install() {
	einstall || die
	dodoc COPYING README THANKS VERSION changelog
	dodoc doc/*.txt
	dohtml doc/*.html
}
