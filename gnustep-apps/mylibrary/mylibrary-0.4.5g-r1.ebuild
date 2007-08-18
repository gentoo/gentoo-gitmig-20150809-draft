# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/mylibrary/mylibrary-0.4.5g-r1.ebuild,v 1.4 2007/08/18 15:21:28 angelos Exp $

inherit gnustep

S=${WORKDIR}/ML

DESCRIPTION="MyLibrary is a combination of wiki-style notes and file collection."
HOMEPAGE="http://www.people.virginia.edu/~yc2w/MyLibrary/"
SRC_URI="http://www.people.virginia.edu/~yc2w/MyLibrary/${P/myl/MyL}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="doc"
DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

egnustep_install_domain "Local"

src_install() {
	egnustep_env
	egnustep_install || die
	if use doc
	then
		mkdir -p ${D}$(egnustep_install_domain)/Library/Documentation/User/MyLibrary
		cp Documentation/*.png ${D}$(egnustep_install_domain)/Library/Documentation/User/MyLibrary
		cp Documentation/*.html ${D}$(egnustep_install_domain)/Library/Documentation/User/MyLibrary
	fi
	egnustep_package_config
}
