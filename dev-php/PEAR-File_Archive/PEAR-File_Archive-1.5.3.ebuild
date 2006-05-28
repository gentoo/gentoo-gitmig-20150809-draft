# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-File_Archive/PEAR-File_Archive-1.5.3.ebuild,v 1.5 2006/05/28 18:14:37 swegener Exp $

inherit php-pear-r1 depend.php

DESCRIPTION="Lets you manipulate easily the tar, gz, tgz, bz2, tbz, zip, ar (or
deb) files."
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
RDEPEND="dev-php/PEAR-MIME_Type
		dev-php/PEAR-Mail_Mime
		dev-php/PEAR-Mail
		dev-php/PEAR-Cache_Lite"
