# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/bitchx/bitchx-1.0.19-r5.ebuild,v 1.15 2004/03/28 14:14:16 zul Exp $

inherit flag-o-matic eutils

IUSE="ssl esd gnome xmms ipv6 gtk cjk"

MY_P=ircii-pana-${PV/.0./.0c}
S=${WORKDIR}/BitchX
DESCRIPTION="An IRC Client"
SRC_URI="ftp://ftp.bitchx.com/pub/BitchX/source/old/${MY_P}.tar.gz"
HOMEPAGE="http://www.bitchx.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

replace-flags -O[3-9] -O2

# BitchX needs to be merged with -fPIC on alpha boxes
# This fixes bug 10932
[ "${ARCH}" = "alpha" ] && append-flags "-fPIC"

# hppa need -fPIC too
[ "${ARCH}" = "hppa" ] && append-flags "-fPIC"

DEPEND=">=sys-libs/ncurses-5.1
	ssl? ( >=dev-libs/openssl-0.9.6 )
	xmms? ( media-sound/xmms )
	esd? ( >=media-sound/esound-0.2.5
		>=media-libs/audiofile-0.1.5 )
	gtk? ( =x11-libs/gtk+-1.2*
		>=media-libs/imlib-1.9.10-r1 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}

	use cjk && epatch ${FILESDIR}/${P}-cjk.patch
	epatch ${FILESDIR}/${P}-gcc-3.3.patch
	epatch ${FILESDIR}/${P}-security.patch || die
	epatch ${FILESDIR}/${P}-security2.patch || die
	epatch ${FILESDIR}/${P}-hebrew.patch || die
}

src_compile() {
	local myconf

	if [ "${DEBUG}" ]
	then
		einfo "debugging"
		myconf="${myconf} --enable-debug"
	fi

	use ssl \
		&& myconf="${myconf} --with-ssl" \
		|| myconf="${myconf} --without-ssl"

	use esd && use gtk \
		&& myconf="${myconf} --enable-sound" \
		|| myconf="${myconf} --disable-sound"

	use gtk && use gnome\
	    && myconf="${myconf} --with-gtk" \
		|| myconf="${myconf} --without-gtk"

	use ipv6 \
		&& myconf="${myconf} --enable-ipv6" \
		|| myconf="${myconf} --disable-ipv6"


	# lamer@gentoo.org BROKEN, will not work with our socks
	# implementations, is looking for a SOCKSConnect function that our
	# dante packages don't have :-(
	# use socks5 \
	#	&& myconf="${myconf} --with-socks=5" \
	#	|| myconf="${myconf} --without-socks"

	mv ${S}/include/config.h ${S}/include/config.h.orig
	sed -e "s/#undef LATIN1/#define LATIN1 ON/;" \
		${S}/include/config.h.orig > \
		${S}/include/config.h
	#ugly workaround
	use gtk && use gnome && ( \
		einfo "gtkBitchX will be built, if you want BitchX please issue"
		einfo "USE="-gtk" emerge bitchx"
		sleep 10
		) && CFLAGS="${CFLAGS} -I/usr/include/gnome-1.0"

	econf CFLAGS="${CFLAGS}" \
		--enable-cdrom \
		--with-plugins \
		${myconf} || die
	emake || die

}

src_install () {

	einstall || die

	rm ${D}/usr/share/man/man1/BitchX*
	doman doc/BitchX.1

	use gnome && use gtk && ( \
		exeinto /usr/bin
	#	newexe ${S}/source/BitchX BitchX-1.0c19
		dosym gtkBitchX-1.0c19 /usr/bin/gtkBitchX
		einfo "Installed gtkBitchX"
	) || dosym BitchX-1.0c19 /usr/bin/BitchX

	chmod -x ${D}/usr/lib/bx/plugins/BitchX.hints

	cd ${S}
	dodoc Changelog README* IPv6-support COPYING
	cd doc
	insinto /usr/X11R6/include/bitmaps
	doins BitchX.xpm

	dodoc BitchX-* BitchX.bot *.doc BitchX.faq README.hooks
	dodoc bugs *.txt functions ideas mode tcl-ideas watch
	dodoc *.tcl
	dohtml *.html

	docinto plugins
	dodoc plugins
	cd ../dll
	insinto /usr/lib/bx/wav
	doins wavplay/*.wav
	cp acro/README acro/README.acro
	dodoc acro/README.acro
	cp arcfour/README arcfour/README.arcfour
	dodoc arcfour/README.arcfour
	cp blowfish/README blowfish/README.blowfish
	dodoc blowfish/README.blowfish
	dodoc nap/README.nap
	cp qbx/README qbx/README.qbx
	dodoc qbx/README.qbx
}
