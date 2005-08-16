# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.3.2-r2.ebuild,v 1.7 2005/08/16 02:55:47 weeve Exp $

inherit kde-dist eutils

DESCRIPTION="KDE educational apps"
SRC_URI="mirror://kde/stable/${PV}/src/${PN}-${PV}.tar.bz2
	http://dev.gentoo.org/~carlo/patches/kstars-3_3.diff.tar.gz"
KEYWORDS="alpha amd64 hppa ~ia64 ppc ppc64 sparc x86"
IUSE=""

src_unpack() {
	#kde_src_unpack
	# Workaround problem on JFS filesystems, see bug 62510
	bzip2 -dc ${DISTDIR}/${PN}-${PV}.tar.bz2 | tar xf -
	unpack kstars-3_3.diff.tar.gz
	cd ${S}
	epatch ${WORKDIR}/kstars-3_3.diff
	epatch ${FILESDIR}/post-3.4.2-kdeedu.diff
	make -f admin/Makefile.common || die
}
