# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PEAR-Log/PEAR-Log-1.8.4.ebuild,v 1.12 2005/05/06 20:18:47 gustavoz Exp $

inherit php-pear

DESCRIPTION="The Log framework provides an abstracted logging system supporting logging to console, file, syslog, SQL, and mcal targets"

LICENSE="PHP"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="pear-db"

DEPEND="pear-db? ( dev-php/PEAR-DB )"
