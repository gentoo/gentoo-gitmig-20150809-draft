# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/note/note-1.2.5.ebuild,v 1.2 2004/01/21 20:34:47 rphillips Exp $

inherit perl-module

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

