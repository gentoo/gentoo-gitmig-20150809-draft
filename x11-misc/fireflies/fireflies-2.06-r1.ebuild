# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fireflies/fireflies-2.06-r1.ebuild,v 1.1 2005/07/27 14:51:35 smithj Exp $

inherit eutils

IUSE=""

DESCRIPTION="Fireflies screensaver: Wicked cool eye candy"
HOMEPAGE="http://somewhere.fscked.org/fireflies/"
SRC_URI="http://somewhere.fscked.org/fireflies/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"

RDEPEND="virtual/x11
	virtual/opengl
	media-libs/libsdl"

DEPEND="${RDEPEND}
	x11-libs/fltk"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-configure.patch
	epatch ${FILESDIR}/${P}-Make.include.in.patch
}

src_compile() {
	local myconf
	local -a mycflagsarr
	local mycppflags

	myconf="${myconf}
		--with-bindir=/usr/lib/misc/xscreensaver
		--with-configdir=/usr/share/xscreensaver/config/"
	mycflagsarr=($CFLAGS `fltk-config --cflags`)
	mycppflags="${mycflagsarr[@]##-[^I]*}"

	econf ${myconf} || die
	emake \
		CFLAGS="$CFLAGS `fltk-config --cflags`" \
		LDLIBS="$LDLIBS `fltk-config --ldflags`" \
		LDFLAGS="$LDFLAGS `fltk-config --ldflags`" \
		CPPFLAGS="$CPPFLAGS ${mycppflags}" \
		|| die
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc COPYING COMPILE README TODO
	dobin add-xscreensaver
}

pkg_postinst() {
	einfo
	einfo "To use fireflies with XScreensaver you need to run"
	einfo "/usr/bin/add-xscreensaver <path to your .xscreensaver file>"
	einfo
}
