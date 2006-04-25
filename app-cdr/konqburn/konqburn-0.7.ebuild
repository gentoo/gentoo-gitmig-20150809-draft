# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/konqburn/konqburn-0.7.ebuild,v 1.1 2006/04/25 19:03:15 deathwing00 Exp $

inherit kde

DESCRIPTION="KDE ioslave to burn CD"
HOMEPAGE="http://www-users.york.ac.uk/~jrht100/burn/"
SRC_URI="http://www-users.york.ac.uk/~jrht100/burn/burn-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="dvdr"

DEPEND="|| ( kde-base/akode <kde-base/kdemultimedia-3.5.0 )
	media-libs/libvorbis
	media-libs/audiofile
	media-libs/taglib
	!>=kde-base/kdelibs-3.5.0
	app-cdr/k3b" # uses libk3b for burner detection; configure uses it if it's detected
RDEPEND="$DEPEND
	virtual/cdrtools
	dvdr? ( app-cdr/dvd+rw-tools )"

S="${WORKDIR}/burn-${PV}"

need-kde 3.3

src_unpack() {
	kde_src_unpack
	# The Portoguese translation return errors.
	rm ${S}/po/pt.po
	rm ${S}/configure
}
