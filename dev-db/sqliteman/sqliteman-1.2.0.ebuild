# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/sqliteman/sqliteman-1.2.0.ebuild,v 1.1 2008/12/31 14:56:55 yngwin Exp $

EAPI=2

inherit eutils cmake-utils

DESCRIPTION="Powerful GUI manager for the Sqlite3 database"
HOMEPAGE="http://sqliteman.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="|| ( ( x11-libs/qt-gui:4
				x11-libs/qt-sql:4[sqlite] )
			  ( =x11-libs/qt-4.3*[sqlite3] ) )
		>=x11-libs/qscintilla-2.1-r1"
DEPEND="${RDEPEND}"

DOCS="AUTHORS README"
