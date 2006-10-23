# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/libopensync-plugin-google-calendar/libopensync-plugin-google-calendar-0.19.ebuild,v 1.1 2006/10/23 20:21:28 peper Exp $

DESCRIPTION="OpenSync Google Calendar Plugin"
HOMEPAGE="http://www.opensync.org/"
SRC_URI="http://dev.gentooexperimental.org/~peper/distfiles/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=app-pda/libopensync-0.19
	dev-python/httplib2"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
