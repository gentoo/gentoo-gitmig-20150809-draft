# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Ebuild by AutoBot (autobot@midsouth.rr.com)
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmclockmon/wmclockmon-0.2.0.ebuild,v 1.5 2003/08/18 01:38:12 g2boojum Exp $

IUSE=""

DESCRIPTION="digital clock dockapp with three different styles."
SRC_URI="http://tnemeth.free.fr/projets/programmes/${P}.tar.gz"
HOMEPAGE="http://tnemeth.free.fr/projets/dockapps.html"

SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

DEPEND="x11-base/xfree
	=x11-libs/gtk+-1.2*"

src_install () {
	einstall || die "make install failed"

	dodoc AUTHORS BUGS ChangeLog THANKS TODO doc/sample.wmclockmonrc
}
