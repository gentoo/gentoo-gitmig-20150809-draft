# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/bitchx/bitchx-1.1-r2.ebuild,v 1.4 2005/03/22 18:40:30 blubb Exp $

inherit flag-o-matic eutils

MY_P=ircii-pana-${PV}-final
S=${WORKDIR}/BitchX
DESCRIPTION="An IRC Client"
HOMEPAGE="http://www.bitchx.org/"
SRC_URI="http://www.bitchx.org/files/source/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~hppa ~amd64"
IUSE="cdrom cjk esd gnome gtk ipv6 ncurses ssl xmms"

DEPEND=">=sys-libs/ncurses-5.1
	ssl? ( >=dev-libs/openssl-0.9.6 )
	ncurses? ( sys-libs/ncurses )
	!arm? (
	xmms? ( media-sound/xmms )
	esd? ( >=media-sound/esound-0.2.5
		>=media-libs/audiofile-0.1.5 )
	!amd64? ( gtk? ( =x11-libs/gtk+-1.2*
		>=media-libs/imlib-1.9.10-r1 ))
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 ) )"

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

	local myconf

	if [ "${DEBUG}" ]
	then
		einfo "debugging"
		myconf="${myconf} --enable-debug"
	fi

	use !amd64 && use esd && use gtk \
		&& myconf="${myconf} --enable-sound" \
		|| myconf="${myconf} --disable-sound"

	use !amd64 && use gtk && use gnome\
	    && myconf="${myconf} --with-gtk" \
		|| myconf="${myconf} --without-gtk"


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
	use !amd64 && use gtk && use gnome && ( \
		einfo "gtkBitchX will be built, if you want BitchX please issue"
		einfo "USE="-gtk" emerge bitchx"
		epause 10
		) && append-flags -I/usr/include/gnome-1.0
	#even uglier hack
	use amd64 && use gtk && use gnome && ( \
		ewarn "gtkBitchX is broken on amd64, so we're building it"
		ewarn "with USE=-gtk. See bug #61133"
		epause 10 )
	econf \
		CFLAGS="${CFLAGS}" \
		SHLIB_CFLAGS="${CFLAGS} -fPIC" \
		--with-plugins \
		`use_enable cdrom` \
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

	use !amd64 && use gnome && use gtk && ( \
		exeinto /usr/bin
		#newexe ${S}/source/BitchX BitchX-1.0c19
		dosym gtkBitchX-1.1-final /usr/bin/gtkBitchX
		einfo "Installed gtkBitchX"
	) || dosym BitchX-1.1-final /usr/bin/BitchX

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
	insinto /usr/lib/bx/wav
	doins wavplay/*.wav
	dodoc nap/README.nap
	newdoc acro/README README.acro
	newdoc arcfour/README README.arcfour
	newdoc blowfish/README README.blowfish
	newdoc qbx/README README.qbx
}
