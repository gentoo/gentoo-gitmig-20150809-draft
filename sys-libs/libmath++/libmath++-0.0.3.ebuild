# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libmath++/libmath++-0.0.3.ebuild,v 1.10 2004/08/31 05:47:30 mr_bones_ Exp $

DESCRIPTION="template based math library, written in C++, for symbolic and numeric calculus applications"
HOMEPAGE="http://www.surakware.net/projects/libmath++/index.xml"
SRC_URI="ftp://ftp.surakware.net/pub/unstable/releases/libmath%2B%2B/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ppc s390"
IUSE=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README TODO
}
