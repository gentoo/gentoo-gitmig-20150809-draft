# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libvncserver/libvncserver-0.9.7.ebuild,v 1.1 2009/01/31 07:37:29 vapier Exp $

inherit libtool

DESCRIPTION="library for creating vnc servers"
HOMEPAGE="http://libvncserver.sourceforge.net/"
SRC_URI="http://libvncserver.sourceforge.net/LibVNCServer-${PV/_}.tar.gz
	mirror://sourceforge/libvncserver/LibVNCServer-${PV/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="nobackchannel no24bpp avahi crypt fbcon jpeg ssl test threads zlib"

DEPEND="avahi? ( net-dns/avahi )
	jpeg? ( media-libs/jpeg )
	ssl? ( dev-libs/openssl )
	zlib? ( sys-libs/zlib )"

S=${WORKDIR}/LibVNCServer-${PV/_}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -r \
		-e '/^CFLAGS =/d' \
		-e "/^SUBDIRS/s:\<($(use test || echo 'test|')client_examples|contrib|examples)\>::g" \
		Makefile.in || die "sed foo"
	use test || sed -i '/^SUBDIRS/s:\<test\>::' Makefile.in
	sed -i \
		-e '/^AM_CFLAGS/s: -g : :' \
		*/Makefile.in || die

	elibtoolize
}

src_compile() {
	econf \
		--without-x11vnc \
		$(use_with !nobackchannel backchannel) \
		$(use_with !no24bpp 24bpp) \
		$(use_with fbcon fbdev) \
		$(use_with jpeg) \
		$(use_with threads pthread) \
		$(use_with zlib) \
		|| die
	emake || die
	emake -C examples noinst_PROGRAMS=storepasswd || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dobin examples/storepasswd
	dodoc AUTHORS ChangeLog NEWS README TODO
}
