# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lwp/lwp-1.10.ebuild,v 1.1 2003/11/15 10:24:49 seemant Exp $

DESCRIPTION="Light weight process library (used by Coda).  This is NOT libwww-perl."
HOMEPAGE="http://www.coda.cs.cmu.edu/"
SRC_URI="ftp://ftp.coda.cs.cmu.edu/pub/lwp/src/${P}.tar.gz"

SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64"

DEPEND="virtual/glibc"

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog NEWS PORTING README
}
