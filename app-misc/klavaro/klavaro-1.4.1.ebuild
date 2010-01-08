# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/klavaro/klavaro-1.4.1.ebuild,v 1.1 2010/01/08 15:15:34 scarabeus Exp $

inherit eutils

DESCRIPTION="Another free touch typing tutor program"
HOMEPAGE="http://klavaro.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/curl
	>=x11-libs/gtk+-2.16.6
	x11-libs/gtkdatabox"

DEPEND="${RDEPEND}
	sys-devel/gettext"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	make_desktop_entry klavaro Klavaro "" Education
	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
}
