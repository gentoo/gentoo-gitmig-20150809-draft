# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kio_burn/kio_burn-0.4.ebuild,v 1.3 2004/11/23 19:31:38 carlo Exp $

inherit kde eutils

DESCRIPTION="KDE ioslave to burn CD"
HOMEPAGE="http://www-users.york.ac.uk/~jrht100/burn/"
SRC_URI="http://www-users.york.ac.uk/~jrht100/burn/burn-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND=">=kde-base/kdebase-3.2.0
	virtual/cdrtools
	media-libs/libvorbis
	media-libs/audiofile"

S=${WORKDIR}/burn-${PV}

need-kde 3.2

src_unpack() {
	kde_src_unpack

	epatch ${FILESDIR}/${P}-kde3.2-compile-fix.patch
}
