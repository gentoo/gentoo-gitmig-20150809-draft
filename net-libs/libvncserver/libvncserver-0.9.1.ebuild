# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libvncserver/libvncserver-0.9.1.ebuild,v 1.9 2007/08/25 14:00:57 vapier Exp $

inherit eutils libtool

DESCRIPTION="library for creating vnc servers"
HOMEPAGE="http://libvncserver.sourceforge.net/"
SRC_URI="http://libvncserver.sourceforge.net/LibVNCServer-${PV/_}.tar.gz
	mirror://sourceforge/libvncserver/LibVNCServer-${PV/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~hppa ia64 ppc sh ~sparc x86 ~x86-fbsd"
IUSE="nobackchannel no24bpp zlib jpeg"

DEPEND="zlib? ( sys-libs/zlib )
	jpeg? ( media-libs/jpeg )"

S=${WORKDIR}/LibVNCServer-${PV/_}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^SUBDIRS/s:x11vnc::' \
		-e '/^CFLAGS =/d' \
		Makefile.in || die "sed foo"
	sed -i \
		-e '/^AM_CFLAGS/s: -g : :' \
		*/Makefile.in || die

	elibtoolize
}

src_compile() {
	econf \
		$(use_with !nobackchannel backchannel) \
		$(use_with !no24bpp 24bpp) \
		$(use_with zlib) \
		$(use_with jpeg) \
		|| die
	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dobin examples/storepasswd
	dodoc AUTHORS ChangeLog NEWS README TODO
}
