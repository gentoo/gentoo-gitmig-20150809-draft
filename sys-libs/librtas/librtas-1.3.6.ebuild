# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/librtas/librtas-1.3.6.ebuild,v 1.1 2012/04/22 12:39:34 ranger Exp $

inherit eutils

DESCRIPTION=" Librtas provides a set of libraries for user-space access to RTAS on the ppc64 architecture."
SRC_URI="http://sourceforge.net/projects/librtas/files//librtas-${PV}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/librtas/"

SLOT="0"
LICENSE="IBM"
KEYWORDS="~ppc ~ppc64"
IUSE=""

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README
}
