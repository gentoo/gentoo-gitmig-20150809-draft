# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/bitchx/bitchx-1.1-r3.ebuild,v 1.2 2006/10/20 11:21:46 jokey Exp $

inherit flag-o-matic eutils

MY_P=ircii-pana-${PV}-final
S=${WORKDIR}/BitchX
DESCRIPTION="An IRC Client"
HOMEPAGE="http://www.bitchx.org/"
SRC_URI="http://www.bitchx.org/files/source/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~sh ~sparc ~x86"
IUSE="cdrom cjk esd gnome gtk ipv6 ncurses ssl xmms"

DEPEND=">=sys-libs/ncurses-5.1
	ssl? ( >=dev-libs/openssl-0.9.6 )
	ncurses? ( sys-libs/ncurses )
	xmms? ( media-sound/xmms )
	esd? (
		>=media-sound/esound-0.2.5
		>=media-libs/audiofile-0.1.5
	)
	gtk? (
		=x11-libs/gtk+-1.2*
		>=media-libs/imlib-1.9.10-r1
	)
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd "${S}"
	use cjk && epatch "${FILESDIR}"/${PV}/${P}-cjk.patch
	epatch "${FILESDIR}"/${PV}/${P}-hebrew.patch
	epatch "${FILESDIR}"/${PV}/${P}-freenode.patch
	epatch "${FILESDIR}"/${PV}/${P}-gcc34.patch
	epatch "${FILESDIR}"/${PV}/${P}-gcc41.patch
	epatch "${FILESDIR}"/${PV}/${P}-headers.patch
	epatch "${FILESDIR}"/${PV}/${P}-build.patch
	epatch "${FILESDIR}"/fPIC.patch
	epatch "${FILESDIR}"/BitchX-64bit.patch

	sed -i \
		-e "s/#undef LATIN1/#define LATIN1 ON/;" \
		include/config.h
}

src_compile() {
	replace-flags -O[3-9] -O2
	append-flags -fno-strict-aliasing

	# bug #147165
	append-flags -I/usr/include/gnome-1.0

	local myconf

	use esd && use gtk \
		&& myconf="${myconf} --enable-sound" \
		|| myconf="${myconf} --disable-sound"
	if use gtk && use gnome ; then
		if use amd64 ; then
			ewarn "gtkBitchX is broken on amd64, so we're building it"
			ewarn "with USE=-gtk.  See http://bugs.gentoo.org/61133"
			myconf="${myconf} --without-gtk"
		else
			einfo "gtkBitchX will be built, if you want BitchX please run:"
			einfo "USE=-gtk emerge bitchx"
			myconf="${myconf} --with-gtk"
		fi
		epause 10
	else
		myconf="${myconf} --without-gtk"
	fi

	# lamer@gentoo.org BROKEN, will not work with our socks
	# implementations, is looking for a SOCKSConnect function that our
	# dante packages don't have :-(
	# use socks5 \
	#	&& myconf="${myconf} --with-socks=5" \
	#	|| myconf="${myconf} --without-socks"

	econf \
		--with-plugins \
		$(use_enable cdrom) \
		$(use_with ssl) \
		$(use_enable ipv6) \
		${myconf} || die

	emake || die "make failed"
	emake -C contrib vh1 || die "make vh1 failed"
}

src_install () {
	einstall || die
	dobin contrib/vh1 || die
	if ! use amd64 && use gnome && use gtk ; then
		dosym gtkBitchX-1.1-final /usr/bin/gtkBitchX
	else
		dosym BitchX-1.1-final /usr/bin/BitchX
	fi

	cd "${S}"
	dodoc bugs Changelog README* IPv6-support

	cd "${S}"/doc
	insinto /usr/include/X11/bitmaps
	doins BitchX.xpm || die
	dodoc README.* *.txt */*.txt tcl/*
	dohtml -r *

	cd "${S}"/dll
	insinto /usr/lib/bx/wav
	doins wavplay/*.wav || die
	docinto plugins
	dodoc nap/README.nap
	newdoc acro/README README.acro
	newdoc arcfour/README README.arcfour
	newdoc blowfish/README README.blowfish
	newdoc qbx/README README.qbx
}
