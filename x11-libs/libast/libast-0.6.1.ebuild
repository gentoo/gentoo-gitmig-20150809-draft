# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libast/libast-0.6.1.ebuild,v 1.3 2005/03/06 11:01:49 corsair Exp $

inherit 64-bit eutils

DESCRIPTION="LIBrary of Assorted Spiffy Things"
HOMEPAGE="http://www.eterm.org/download/"
SRC_URI="http://www.eterm.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~ppc64"
IUSE="imlib mmx pcre"

DEPEND="virtual/x11
	=media-libs/freetype-2*
	imlib? ( media-libs/imlib2 )
	pcre? ( dev-libs/libpcre )"

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
