# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x11vnc/x11vnc-0.6.2.ebuild,v 1.1 2004/11/22 00:57:41 swegener Exp $

inherit eutils

DESCRIPTION="A VNC server for real X displays"
HOMEPAGE="http://www.karlrunge.com/x11vnc/"
SRC_URI="mirror://sourceforge/libvncserver/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="jpeg zlib"

RDEPEND="virtual/x11
	zlib? ( sys-libs/zlib )
	jpeg? (
		media-libs/jpeg
		sys-libs/zlib
	)"
DEPEND="${RDEPEND}
	sys-devel/autoconf"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Hack to avoid running all autotools
	touch -r configure configure.timestamp
	touch -r configure.ac configure.ac.timestamp

	epatch ${FILESDIR}/${PV}-configure.ac.patch
	WANT_AUTOCONF="2.5" autoconf || die "autoconf failed"

	touch -r configure.timestamp configure
	touch -r configure.ac.timestamp configure.ac
}

src_compile() {
	econf \
		$(use_with jpeg) \
		$(use_with jpeg zlib) \
		$(use_with zlib) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
