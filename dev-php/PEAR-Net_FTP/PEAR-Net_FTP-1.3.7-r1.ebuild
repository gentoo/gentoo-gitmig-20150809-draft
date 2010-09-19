# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Net_FTP/PEAR-Net_FTP-1.3.7-r1.ebuild,v 1.1 2010/09/19 12:00:22 mabi Exp $

EAPI="3"

inherit php-pear-r1

DESCRIPTION="Provides an OO interface to the PHP FTP functions"

LICENSE="PHP-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/php[ftp]"
