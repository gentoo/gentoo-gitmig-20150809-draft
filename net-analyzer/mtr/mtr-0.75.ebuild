# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mtr/mtr-0.75.ebuild,v 1.8 2009/11/15 12:29:26 armin76 Exp $

EAPI="2"
inherit eutils autotools

DESCRIPTION="My TraceRoute. Excellent network diagnostic tool."
HOMEPAGE="http://www.bitwizard.nl/mtr/"
SRC_URI="ftp://ftp.bitwizard.nl/mtr/${P}.tar.gz
		mirror://gentoo/gtk-2.0-for-mtr.m4.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 s390 sh sparc ~x86"
IUSE="gtk ipv6"

RDEPEND="sys-libs/ncurses
	gtk? ( >=x11-libs/gtk+-2.4.0 )"
DEPEND="${RDEPEND}
	gtk? ( dev-util/pkgconfig )"

src_prepare() {
	epatch "${FILESDIR}/${P}--Wno-pointer-sign.patch"
	# Keep this comment and following move, even incase ebuild does not needs
	# it: kept gtk-2.0.m4 in SRC_URI but you'll have to mv it before autoreconf
	mv "${WORKDIR}"/gtk-2.0-for-mtr.m4 gtk-2.0.m4 #222909
	AT_M4DIR="." eautoreconf
}
src_configure() {
	econf \
		$(use_with gtk) \
		$(use_enable ipv6)
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	fowners root:0 /usr/sbin/mtr
	fperms 4710 /usr/sbin/mtr

	dodoc AUTHORS ChangeLog FORMATS NEWS README SECURITY TODO || die
}
