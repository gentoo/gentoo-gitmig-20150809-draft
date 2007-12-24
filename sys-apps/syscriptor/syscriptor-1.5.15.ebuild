# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/syscriptor/syscriptor-1.5.15.ebuild,v 1.1 2007/12/24 12:42:23 vapier Exp $

DESCRIPTION="display misc information about your hardware"
HOMEPAGE="http://syscriptor.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

S=${WORKDIR}/${PN}

src_install () {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS CREDITS ChangeLog HISTORY NEWS README TODO
}
