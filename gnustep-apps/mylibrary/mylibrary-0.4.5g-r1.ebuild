# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/mylibrary/mylibrary-0.4.5g-r1.ebuild,v 1.1 2004/11/12 03:54:39 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/ML

DESCRIPTION="MyLibrary is a combination of wiki-style notes and file collection."
HOMEPAGE="http://www.people.virginia.edu/~yc2w/MyLibrary/"
SRC_URI="http://www.people.virginia.edu/~yc2w/MyLibrary/${P/myl/MyL}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="${IUSE} doc"
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

