# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/phat/phat-0.2.3.ebuild,v 1.3 2004/11/21 21:28:31 eradicator Exp $

IUSE="debug doc"

DESCRIPTION="PHAT is a collection of GTK+ widgets geared toward pro-audio apps."
HOMEPAGE="http://www.gazuga.net/phat.php"
SRC_URI="http://www.gazuga.net/phatfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=">x11-libs/gtk+-2*"

src_compile() {
	econf $(use_enable debug) \
	      $(use_enable doc gtk-doc) || die

	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
