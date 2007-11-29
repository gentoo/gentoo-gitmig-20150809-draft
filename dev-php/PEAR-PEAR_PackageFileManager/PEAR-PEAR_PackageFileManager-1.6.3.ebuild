# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-PEAR_PackageFileManager/PEAR-PEAR_PackageFileManager-1.6.3.ebuild,v 1.1 2007/11/29 23:34:43 jokey Exp $

inherit php-pear-r1

DESCRIPTION="Takes an existing package.xml file and updates it with a new filelist and changelog."

LICENSE="PHP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="minimal"

RDEPEND="!minimal? ( >=dev-php/PEAR-PHP_CompatInfo-1.4.0 )"
