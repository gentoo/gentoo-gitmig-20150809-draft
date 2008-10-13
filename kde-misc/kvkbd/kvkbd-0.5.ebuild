# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kvkbd/kvkbd-0.5.ebuild,v 1.1 2008/10/13 18:50:16 yngwin Exp $

ARTS_REQUIRED="never"
inherit kde

KDEAPPS_ID="56019"

DESCRIPTION="A virtual keyboard for KDE"
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=56019"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/${KDEAPPS_ID}-${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( kde-base/kate kde-base/kdebase )"
RDEPEND="${DEPEND}"

need-kde 3.5

src_unpack() {
	kde_src_unpack

	# Make it stop whining about unsermake
	rm "${S}"/configure

	# Add headers needed for gcc-4.3
	epatch "${FILESDIR}"/gcc43-fix.patch

	# Fix .desktop so it doesn't end up in Lost&Found
	echo 'Categories=Qt;KDE;Utility;X-KDE-Utilities-Desktop;' \
		>> "${S}"/src/kvkbd.desktop
}
