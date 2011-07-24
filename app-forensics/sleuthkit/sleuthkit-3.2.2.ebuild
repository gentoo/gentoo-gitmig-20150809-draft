# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/sleuthkit/sleuthkit-3.2.2.ebuild,v 1.3 2011/07/24 18:22:23 armin76 Exp $

EAPI="4"

DESCRIPTION="A collection of file system and media management forensic analysis tools"
HOMEPAGE="http://www.sleuthkit.org/sleuthkit/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 IBM"
SLOT=0
KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="aff ewf"

DEPEND="ewf? ( app-forensics/libewf )
	aff? ( app-forensics/afflib )"
RDEPEND="${DEPEND}
	dev-perl/DateManip"

DOCS="NEWS.txt README.txt"

src_configure() {
	econf \
		$(use_with aff afflib) \
		$(use_with ewf libewf)
}
