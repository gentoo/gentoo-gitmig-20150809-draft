# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libvncserver/libvncserver-0.7.ebuild,v 1.3 2006/03/08 02:00:07 vapier Exp $

inherit eutils

DESCRIPTION="library for creating vnc servers"
HOMEPAGE="http://libvncserver.sourceforge.net/"
SRC_URI="mirror://sourceforge/libvncserver/LibVNCServer-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE="nobackchannel no24bpp zlib jpeg"

DEPEND="zlib? ( sys-libs/zlib )
	jpeg? ( media-libs/jpeg )"

S=${WORKDIR}/LibVNCServer-${PV}

src_unpack() {
	unpack LibVNCServer-${PV}.tar.gz
	cd ${S}
	sed -i \
		-e '/^SUBDIRS/s:x11vnc::' \
		Makefile.in || die "sed foo"
}

src_compile() {
	local myconf=""
	use nobackchannel \
		&& myconf="${myconf} --without-backchannel" \
		|| myconf="${myconf} --with-backchannel"
	use no24bpp \
		&& myconf="${myconf} --without-24bpp" \
		|| myconf="${myconf} --with-24bpp"
	econf \
		$(use_with zlib) \
		$(use_with jpeg) \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dobin examples/storepasswd
	dodoc AUTHORS ChangeLog NEWS README TODO
}
