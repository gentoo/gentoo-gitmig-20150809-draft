# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/w3m/w3m-0.4.1.ebuild,v 1.1 2003/05/07 13:03:37 phosphan Exp $

inherit eutils

IUSE="gpm cjk imlib ssl"

DESCRIPTION="Text based WWW browser, supports tables and frames"
SRC_URI="mirror://sourceforge/w3m/${P}.tar.gz"
HOMEPAGE="http://w3m.sourceforge.net/"

SLOT="0"
LICENSE="w3m"
KEYWORDS="~x86"

DEPEND=">=sys-libs/ncurses-5.2-r3
	>=sys-libs/zlib-1.1.3-r2
	imlib? ( >=media-libs/imlib-1.9.8 media-libs/compface )
	gpm? ( >=sys-libs/gpm-1.19.3-r5 )
	ssl? ( >=dev-libs/openssl-0.9.6b )"

PROVIDE="virtual/textbrowser"

src_unpack() {
	unpack ${A}
	cd ${S}
	if use alpha; then
		epatch ${FILESDIR}/w3m-0.4-alpha.patch || die "epatch failed"
	fi
}

src_compile() {
	local myuse
	myuse="use_cookie=y use_ansi_color=y"

	local myconf
	myconf="-prefix=/usr -mandir=/usr/share/man -sysconfdir=/etc/w3m \
		--gc-includedir=/usr/include/gc --gc-libdir=/usr/lib \
		-cflags=${CFLAGS} -model=custom -nonstop"

	if use cjk &>/dev/null; then
		myconf="${myconf} -lang=ja -code=E"
	else
		myconf="${myconf} -lang=en"
	fi

	if use ssl &>/dev/null; then
		myconf="${myconf} --ssl-includedir=/usr/include/openssl --ssl-libdir=/usr/lib"
		myuse="${myuse} use_ssl=yes use_ssl_verify=n use_digest_auth=y"
	else
		myuse="${myuse} use_ssl=no"
	fi
	
	if use gpm &>/dev/null; then
		myuse="${myuse} use_mouse=y"
	else
		myuse="${myuse} use_mouse=n"
	fi

	if use imlib &>/dev/null; then
		myuse="${myuse} use_image=y use_w3mimg_x11=y use_w3mimg_fb=y w3mimgdisplay_setuid=n use_xface=y"
	else
		myuse="${myuse} use_image=n"
	fi

	env ${myuse} ./configure ${myconf} || die "configure failed"

	# Test to make sure the above configuration was sane
	grep -q "dcc='gcc'" config.param || \
		die "configure out of sync; ebuild needs an update"

	# binary executables come prebuilt for 80386! 
	# clean it up and be sure to remake for ANY arch
	cd ${S}/gc
	make clean
	cd -
	
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc doc/* README*
	doman doc/w3m.1
}
