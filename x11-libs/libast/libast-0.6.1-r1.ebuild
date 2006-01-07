# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libast/libast-0.6.1-r1.ebuild,v 1.3 2006/01/07 08:04:50 vapier Exp $

inherit eutils

DESCRIPTION="LIBrary of Assorted Spiffy Things"
HOMEPAGE="http://www.eterm.org/download/"
SRC_URI="http://www.eterm.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="imlib mmx pcre"

DEPEND="|| ( ( x11-libs/libXt x11-proto/xproto x11-libs/libICE x11-libs/libSM x11-libs/libX11 ) virtual/x11 )
	=media-libs/freetype-2*
	imlib? ( media-libs/imlib2 )
	pcre? ( dev-libs/libpcre )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-config-warning.patch #94479
}

src_compile() {
	local myregexp="posix"
	use pcre && myregexp="pcre"
	econf \
		$(use_with imlib) \
		$(use_enable mmx) \
		--with-regexp=${myregexp} \
		|| die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README DESIGN ChangeLog
}
