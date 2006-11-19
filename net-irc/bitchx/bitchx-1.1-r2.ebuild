# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/bitchx/bitchx-1.1-r2.ebuild,v 1.8 2006/11/19 02:10:35 compnerd Exp $

inherit flag-o-matic eutils

MY_P=ircii-pana-${PV}-final
S=${WORKDIR}/BitchX
DESCRIPTION="An IRC Client"
HOMEPAGE="http://www.bitchx.org/"
SRC_URI="http://www.bitchx.org/files/source/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~hppa ~amd64"
IUSE="cjk ipv6 ssl"

DEPEND=">=sys-libs/ncurses-5.1
	ssl? ( >=dev-libs/openssl-0.9.6 )"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}

	use cjk && epatch ${FILESDIR}/${PV}/${P}-cjk.patch
	epatch ${FILESDIR}/${PV}/${P}-hebrew.patch
	epatch ${FILESDIR}/${PV}/${P}-freenode.patch
	epatch ${FILESDIR}/${PV}/${P}-gcc34.patch
	epatch ${FILESDIR}/fPIC.patch
	use amd64 && epatch ${FILESDIR}/BitchX-64bit.patch
}

src_compile() {
	# BitchX needs to be merged with -fPIC on alpha/hppa boxes #10932
	replace-flags -O[3-9] -O2

	local myconf="--disable-cdrom --disable-sound --without-gtk"

	if [ "${DEBUG}" ]
	then
		einfo "debugging"
		myconf="${myconf} --enable-debug"
	fi

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

	econf \
		CFLAGS="${CFLAGS}" \
		SHLIB_CFLAGS="${CFLAGS} -fPIC" \
		--with-plugins \
		`use_with ssl` \
		`use_enable ipv6` \
		${myconf} || die

	emake || die make failed
	cd contrib && make vh1
}

src_install () {
	einstall || die
	[ -f contrib/vh1 ] && cp contrib/vh1 ${D}/usr/bin/
	rm ${D}/usr/share/man/man1/BitchX*
	doman doc/BitchX.1

	dosym BitchX-1.1-final /usr/bin/BitchX
	fperms a-x /usr/lib/bx/plugins/BitchX.hints

	cd ${S}
	dodoc Changelog README* IPv6-support
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
	dodoc nap/README.nap
	newdoc acro/README README.acro
	newdoc arcfour/README README.arcfour
	newdoc blowfish/README README.blowfish
	newdoc qbx/README README.qbx
}
