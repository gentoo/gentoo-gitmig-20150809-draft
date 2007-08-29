# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-0.81.ebuild,v 1.1 2007/08/29 02:34:58 compnerd Exp $

inherit eutils

MY_PN="Transmission"

DESCRIPTION="Simple BitTorrent client"
HOMEPAGE="http://transmission.m0k.org/"
SRC_URI="http://download.m0k.org/transmission/files/${MY_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="daemon gtk wxwindows"

RDEPEND="sys-devel/gettext
		 dev-libs/openssl
		 >=dev-libs/glib-2.6
		 daemon? ( dev-libs/libevent )
		 gtk? ( >=x11-libs/gtk+-2.6 )
		 wxwindows? ( >=x11-libs/wxGTK-2.6 )"
DEPEND="${RDEPEND}
		sys-devel/gettext
		>=dev-util/pkgconfig-0.19"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix man page install location
	sed -i -e 's|/man/man1|/share/man/man1|' mk/common.mk
}

src_compile() {
	econf $(use_enable daemon) $(use_enable gtk) $(use_with wxwindows wx) || die "configure failed"
	emake || die "build failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS NEWS README
}
