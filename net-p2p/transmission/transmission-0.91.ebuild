# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-0.91.ebuild,v 1.2 2007/11/10 03:53:32 compnerd Exp $

inherit autotools

DESCRIPTION="Simple BitTorrent client"
HOMEPAGE="http://transmission.m0k.org/"
SRC_URI="http://download.m0k.org/transmission/files/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="gtk wxwindows"

RDEPEND=">=dev-libs/glib-2.6
		 >=dev-libs/openssl-0.9.8
		 gtk? ( >=x11-libs/gtk+-2.6 )
		 wxwindows? ( =x11-libs/wxGTK-2.6* )"
DEPEND="${RDEPEND}
		sys-devel/gettext
		>=dev-util/pkgconfig-0.19
		gtk? ( >=dev-util/intltool-0.35 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Fix po/Makefile generation (bug #198225)
	if ! use gtk ; then
		epatch "${FILESDIR}/${PN}-0.91-potfiles-fix.patch"
		eautoreconf
	fi
}

src_compile() {
	econf $(use_with gtk) $(use_with wxwindows wx) || die "configure failed"
	emake || die "build failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS NEWS
}
