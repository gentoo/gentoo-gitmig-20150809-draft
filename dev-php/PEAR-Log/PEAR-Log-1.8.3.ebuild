# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Log/PEAR-Log-1.8.3.ebuild,v 1.1 2004/01/10 00:06:21 coredumb Exp $

inherit php-pear

IUSE="pear-db"
DESCRIPTION="The Log framework provides an abstracted logging system supporting logging to console, file, syslog, SQL, and mcal targets."
LICENSE="PHP"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
DEPEND="pear-db? ( dev-php/PEAR-DB )"
