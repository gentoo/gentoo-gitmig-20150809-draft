# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kio_burn/kio_burn-0.6.2.ebuild,v 1.1 2005/01/30 13:49:43 motaboy Exp $

inherit kde eutils

DESCRIPTION="KDE ioslave to burn CD"
HOMEPAGE="http://www-users.york.ac.uk/~jrht100/burn/"
SRC_URI="http://www-users.york.ac.uk/~jrht100/burn/burn-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="dvdr"

DEPEND="|| ( kde-base/akode >=kde-base/kdemultimedia-3.3.0 )
	media-libs/libvorbis
	media-libs/audiofile"
RDEPEND="virtual/cdrtools
	dvdr? ( app-cdr/dvd+rw-tools )"

S=${WORKDIR}/burn-${PV}

need-kde 3.3

src_unpack() {
	kde_src_unpack
	# The Portoguese translation return errors.
	rm ${S}/po/pt.po
	rm ${S}/configure
}

