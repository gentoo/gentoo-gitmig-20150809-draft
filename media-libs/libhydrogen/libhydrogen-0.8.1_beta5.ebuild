# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libhydrogen/libhydrogen-0.8.1_beta5.ebuild,v 1.1 2003/12/10 07:24:32 torbenh Exp $

inherit libtool

MY_P=${P/_/}

DESCRIPTION="Linux Drum Machine - Libary"
HOMEPAGE="http://hydrogen.sourceforge.net"
SRC_URI="mirror://sourceforge/hydrogen/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

S="${WORKDIR}/${MY_P}"

DEPEND="virtual/x11 \
	>=media-libs/audiofile-0.2.3 \
	alsa? ( media-libs/alsa-lib ) \
	virtual/jack"

src_compile() {
	einfo "Reconfiguring..."
	export WANT_AUTOCONF_2_5=1
	aclocal
	autoconf
	automake

	elibtoolize

	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS ChangeLog FAQ README TODO
}
