# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.3.1.ebuild,v 1.2 2004/10/16 19:05:56 weeve Exp $

inherit kde-dist eutils

DESCRIPTION="KDE educational apps"

KEYWORDS="~x86 ~amd64 ~sparc ~ppc ~ppc64 ~hppa"
IUSE=""

src_unpack() {
	#kde_src_unpack
	# Workaround problem on JFS filesystems, see bug 62510
	bzip2 -dc ${DISTDIR}/${A} | tar xf -
	cd ${S}
	# Fix for SPARC compilation issues, may also work for PPC, PPC64
	use ppc64 && epatch ${FILESDIR}/${P}-sparc.patch
	use ppc && epatch ${FILESDIR}/${P}-sparc.patch
}
