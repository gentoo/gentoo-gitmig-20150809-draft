# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/note/note-1.2.5.ebuild,v 1.5 2005/11/28 12:09:19 mcummings Exp $

inherit perl-app

DESCRIPTION="a note taking perl program"
SRC_URI="ftp://ftp.daemon.de/scip/Apps/note/${P}.tar.gz"
HOMEPAGE="http://www.daemon.de/NOTE"
IUSE="crypt mysql"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DEPEND="dev-perl/TermReadKey
		dev-perl/Term-ReadLine-Perl
		crypt? ( dev-perl/crypt-cbc dev-perl/Crypt-Blowfish )
		mysql? ( dev-db/mysql dev-perl/DBD-mysql )"

