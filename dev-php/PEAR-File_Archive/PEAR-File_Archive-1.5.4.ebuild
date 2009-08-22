# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File_Archive/PEAR-File_Archive-1.5.4.ebuild,v 1.1 2009/08/22 18:45:12 beandog Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Lets you manipulate easily the tar, gz, tgz, bz2, tbz, zip, ar (or
deb) files."
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="minimal"
RDEPEND="dev-php/PEAR-MIME_Type
	!minimal? ( dev-php/PEAR-Mail_Mime
		dev-php/PEAR-Mail
		>=dev-php/PEAR-Cache_Lite-1.5.0 )"
