# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/gnokii/gnokii-0.4.3.ebuild,v 1.8 2004/07/14 22:54:25 agriffis Exp $

DESCRIPTION="a client that plugs into your handphone"
SRC_URI="http://freesoftware.fsf.org/download/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnokii.org"

IUSE="nls X"
DEPEND="X? ( virtual/x11 x11-libs/gtk+ )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
SANDBOX_DISABLED="1"

src_compile() {
	local myconf

	use nls \
		&& myconf="--enable-nls" \
		|| myconf="--disable-nls"
	use X \
		&& myconf="${myconf} --with-x" \
		|| myconf="${myconf} --without-x"
	econf \
		--prefix=/usr \
		--enable-security \
		${myconf} || die
	make CC="gcc ${CFLAGS}" || die "make failed (myconf=${myconf})"
}

src_install () {
	groupadd gnokii
	make DESTDIR=$D install-ss || die "install failed"

	dodoc Docs/Bugs Docs/CREDITS Docs/DataCalls-QuickStart Docs/FAQ Docs/Makefile
	dodoc Docs/README Docs/README-2110 Docs/README-3810 Docs/README-6110 Docs/README-6510 Docs/README-7110
	dodoc Docs/README-WIN32 Docs/README-dancall Docs/README-ericsson Docs/README.libsms
	dodoc Docs/gettext-howto Docs/gnokii-IrDA-Linux Docs/gnokii-hackers-howto Docs/gnokii-ir-howto
	dodoc Docs/gnokii.nol Docs/logos.txt Docs/packaging-howto Docs/ringtones.txt
	dodoc Docs/protocol/nk2110.txt Docs/protocol/nk3110.txt Docs/protocol/nk6110.txt Docs/protocol/nk6160.txt Docs/protocol/nk6185.txt Docs/protocol/nk640.txt Docs/protocol/nk6510.txt Docs/protocol/nk7110.txt Docs/protocol/nokia.txt

	dodoc Docs/sample/logo/bronto.xpm Docs/sample/logo/gnokii.xpm Docs/sample/logo/gnokiiop.xpm Docs/sample/logo/horse.xpm Docs/sample/logo/horse2.xpm Docs/sample/logo/pacman.xpm
	dodoc Docs/sample/cimd-connect Docs/sample/gnokiirc Docs/sample/magic
	dodoc Docs/sample/options Docs/sample/pap-secrets Docs/sample/ppp-6210-modem Docs/sample/ppp-FILES Docs/sample/ppp-gnokii Docs/sample/ppp-hscsd Docs/sample/ppp-on
	dodoc Docs/sample/ringtone/star.imelody Docs/sample/ringtone/star.rtttl
	dodoc Docs/sample/vCalendar/test.vcs

	doman Docs/man/gnokii.1 Docs/man/gnokiid.8 Docs/man/mgnokiidev.8 Docs/man/todologo.1 Docs/man/xgnokii.1x
	mkdir $D/etc
	sed 's#/usr/local/sbin/#/usr/sbin/#' <Docs/sample/gnokiirc > $D/etc/gnokiirc
}

src_postrm () {
	groupdel gnokii
}
