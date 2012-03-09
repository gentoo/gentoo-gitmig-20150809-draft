# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/vanessa-logger/vanessa-logger-0.0.9.ebuild,v 1.1 2012/03/09 09:44:43 patrick Exp $

MY_PN="${PN/-/_}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Generic logging layer that may be used to log to one or more of syslog, an open file handle or a file name."
HOMEPAGE="http://www.vergenet.net/linux/vanessa/"
SRC_URI="http://www.vergenet.net/linux/vanessa/download/${MY_PN}/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~x86"
IUSE=""

DEPEND=""

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install || die "error installing"
	dodoc AUTHORS NEWS README TODO sample/*.c sample/*.h
}
