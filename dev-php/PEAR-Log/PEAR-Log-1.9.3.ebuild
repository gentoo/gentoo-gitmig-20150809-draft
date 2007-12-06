# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Log/PEAR-Log-1.9.3.ebuild,v 1.15 2007/12/06 00:30:38 jokey Exp $

inherit php-pear-r1

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 s390 sparc x86"

DESCRIPTION="The Log framework provides an abstracted logging system. It supports logging to console, file, syslog, SQL, Sqlite, mail, and mcal targets."
LICENSE="PHP-3.01"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=">=dev-php/PEAR-DB-1.7.6-r1"
