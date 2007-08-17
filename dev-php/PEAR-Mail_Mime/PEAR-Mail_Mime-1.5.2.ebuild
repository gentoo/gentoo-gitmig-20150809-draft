# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Mail_Mime/PEAR-Mail_Mime-1.5.2.ebuild,v 1.1 2007/08/17 15:38:24 hoffie Exp $

inherit php-pear-r1 eutils

DESCRIPTION="Provides classes to deal with creation and manipulation of mime messages"

LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-php/PEAR-PEAR-1.6.0"
PDEPEND="dev-php/PEAR-Mail_mimeDecode"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# see Bug 125451; http://pear.php.net/bugs/bug.php?id=5333
	epatch "${FILESDIR}"/1.5.2-php-pass-by-reference-fix.patch
}
