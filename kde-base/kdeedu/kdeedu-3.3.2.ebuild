# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.3.2.ebuild,v 1.9 2005/01/25 01:20:56 vapier Exp $

inherit kde-dist eutils

DESCRIPTION="KDE educational apps"

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

src_unpack() {
	#kde_src_unpack
	# Workaround problem on JFS filesystems, see bug 62510
	bzip2 -dc ${DISTDIR}/${A} | tar xf -
	cd ${S}
}
