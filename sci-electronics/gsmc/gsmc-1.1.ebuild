# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gsmc/gsmc-1.1.ebuild,v 1.1 2011/01/02 15:59:14 tomjbe Exp $

EAPI="2"

DESCRIPTION="A GTK program for doing Smith Chart calculations"
HOMEPAGE="http://www.qsl.net/ik5nax/"
SRC_URI="http://www.qsl.net/ik5nax/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/glib
	x11-libs/gtk+:2"
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README TODO || die
	insinto /usr/share/${PN}
	doins example* || die
}
