# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/bbpager/bbpager-0.4.3.ebuild,v 1.1 2007/07/02 22:17:27 omp Exp $

DESCRIPTION="An understated pager for Blackbox."
HOMEPAGE="http://bbtools.sourceforge.net/"
SRC_URI="mirror://sourceforge/bbtools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND="x11-wm/blackbox"
RDEPEND="${DEPEND}"

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS BUGS ChanegLog README TODO
}
