# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/reinhardtstyle/reinhardtstyle-0.8.2.ebuild,v 1.5 2006/10/10 09:09:33 deathwing00 Exp $

inherit kde

# kde-look.org prefixes filenames
MY_PN="5962-reinhardtstyle"
MY_P="${MY_PN}-${PV}"

WANT_AUTOMAKE="1.6"
WANT_AUTOCONF="2.1"

DESCRIPTION="Minimalistic KDE style heavily based on clee's dotNET"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=5962"
SRC_URI="http://www.kde-look.org/content/files/${MY_P}.tar.bz2
		mirror://gentoo/kde-admindir-3.5.3.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

KEYWORDS="x86 ~ppc sparc"

ARTS_REQUIRED="never"

DEPEND="|| ( kde-base/kwin kde-base/kdebase )"

RDEPEND="${DEPEND}"

need-kde 3.2

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -rf "${S}/admin" "${S}/configure"
	ln -s "${WORKDIR}/admin" "${S}/admin"
}

