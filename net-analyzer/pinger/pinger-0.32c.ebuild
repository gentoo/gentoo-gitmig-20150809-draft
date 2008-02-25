# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pinger/pinger-0.32c.ebuild,v 1.3 2008/02/25 18:59:28 pva Exp $

inherit eutils autotools

DESCRIPTION="Cyclic multi ping utility for selected adresses using GTK/ncurses."
HOMEPAGE="http://aa.vslib.cz/silk/projekty/pinger/index.php"
SRC_URI="http://aa.vslib.cz/silk/projekty/pinger/download/${P}.tar.gz
		mirror://gentoo/gtk-2.0-for-pinger.m4.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk nls"

DEPEND=">=dev-util/pkgconfig-0.12
	gtk? ( >=x11-libs/gtk+-2.4.0 )
	sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/disable_gtk.patch
	cp "${WORKDIR}"/gtk-2.0-for-pinger.m4 m4/

	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	! use nls && myconf="${myconf} --disable-nls"

	econf \
		$(use_enable gtk) \
		${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README

	use gtk || rm "${D}"/usr/bin/gtkpinger
}
