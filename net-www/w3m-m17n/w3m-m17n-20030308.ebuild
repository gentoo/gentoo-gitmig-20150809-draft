# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/w3m-m17n/w3m-m17n-20030308.ebuild,v 1.1 2003/06/20 13:47:54 yakina Exp $

IUSE="gpm imlib ssl"

W3M_PV="0.4.1"
GC_PV="6.2alpha5"
DESCRIPTION="Multilingual text based WWW browser"
SRC_URI="http://www2u.biglobe.ne.jp/~hsaka/w3m/patch/w3m-${W3M_PV}-stable-m17n-${PV}.tar.gz
	http://www.hpl.hp.com/personal/Hans_Boehm/gc/gc_source/gc${GC_PV}.tar.gz"
HOMEPAGE="http://www2u.biglobe.ne.jp/~hsaka/w3m/"

SLOT="0"
LICENSE="w3m"
KEYWORDS="~x86 ~alpha"

DEPEND=">=sys-libs/ncurses-5.2-r3
	>=sys-libs/zlib-1.1.3-r2
	dev-lang/perl
	imlib? ( >=media-libs/imlib-1.9.8 media-libs/compface )
	gpm? ( >=sys-libs/gpm-1.19.3-r5 )
	ssl? ( >=dev-libs/openssl-0.9.6b )"

PROVIDE="virtual/textbrowser"

S="${WORKDIR}/w3m-${W3M_PV}-stable-m17n-${PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# the boehm-gc which comes with w3m cannot be compiled on alpha
	rm -rf gc
	unpack gc${GC_PV}.tar.gz
	mv gc${GC_PV} gc
}

src_compile() {
	local myuse
	myuse="use_cookie=y use_ansi_color=y use_history=y \
		use_unicode=y charset=UTF-8"

	local myconf
	myconf="-prefix=/usr -mandir=/usr/share/man -sysconfdir=/etc/w3m \
		-suffix=-m17n -lang=en -model=custom -nonstop"

	if [ -n "`use ssl`" ] ; then
		myconf="${myconf} --ssl-includedir=/usr/include/openssl --ssl-libdir=/usr/lib"
		myuse="${myuse} use_ssl=y use_ssl_verify=n use_digest_auth=y"
	else
		myuse="${myuse} use_ssl=no"
	fi
	
	if [ -n "`use gpm`" ] ; then
		myuse="${myuse} use_mouse=y"
	else
		myuse="${myuse} use_mouse=n"
	fi

	if [ -n "`use imlib`" ] ; then
		myuse="${myuse} use_image=y use_w3mimg_x11=y use_w3mimg_fb=y w3mimgdisplay_setuid=n use_xface=y"
	else
		myuse="${myuse} use_image=n"
	fi

	env ${myuse} ./configure ${myconf} -cflags="${CFLAGS}" \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	einstall DESTDIR=${D}

	# w3mman and manpages conflict with those from w3m
	mv ${D}/usr/bin/w3mman ${D}/usr/bin/w3mman-m17n
	mv ${D}/usr/share/man/ja/man1/w3m{,-m17n}.1
	mv ${D}/usr/share/man/man1/w3m{,-m17n}.1
	mv ${D}/usr/share/man/man1/w3mman{,-m17n}.1

	dodoc doc/* README*
}
