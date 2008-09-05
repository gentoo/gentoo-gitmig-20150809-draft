# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/qstat/qstat-2.11.ebuild,v 1.4 2008/09/05 18:39:08 gentoofan23 Exp $

DESCRIPTION="Server statics collector supporting many FPS games"
HOMEPAGE="http://www.qstat.org/"
SRC_URI="mirror://sourceforge/qstat/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="!sys-cluster/torque"

src_compile() {
	econf $(use_enable debug) || die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dosym qstat /usr/bin/quakestat

	dodoc CHANGES.txt COMPILE.txt template/README.txt
	dohtml template/*.html qstatdoc.html
}
