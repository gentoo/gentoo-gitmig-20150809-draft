# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/x11vnc/x11vnc-0.7.ebuild,v 1.3 2005/01/06 22:51:58 sekretarz Exp $

inherit eutils

DESCRIPTION="A VNC server for real X displays"
HOMEPAGE="http://www.karlrunge.com/x11vnc/"
SRC_URI="mirror://sourceforge/libvncserver/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~hppa ~amd64"
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

	epatch ${FILESDIR}/0.6.2-configure.ac.patch
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
	dodoc x11vnc/{ChangeLog,README} || die "dodoc failed"
}
