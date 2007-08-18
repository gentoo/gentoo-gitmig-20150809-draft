# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-DB_DataObject/PEAR-DB_DataObject-1.8.7.ebuild,v 1.1 2007/08/18 18:36:28 hoffie Exp $

inherit php-pear-r1

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="An SQL Builder, Object Interface to Database Tables."
LICENSE="PHP"
SLOT="0"
IUSE="minimal"

DEPEND=""
RDEPEND=">=dev-php/PEAR-DB-1.7.6-r1
	>=dev-php/PEAR-Date-1.4.3-r1
	!minimal? ( >=dev-php/PEAR-Validate-0.5.0-r1
		    >=dev-php/PEAR-MDB2-2.0.0_rc1 )"

src_unpack() {
	unpack "${A}"
	# don't install windows-only stuff
	sed -re 's:<file baseinstalldir="DB" md5sum=".{32}" name="scripts/DB_DataObject_createTables.bat" role="script" />::' -i package.xml || die "sed failed"
}
