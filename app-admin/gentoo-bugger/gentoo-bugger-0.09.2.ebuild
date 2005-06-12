# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gentoo-bugger/gentoo-bugger-0.09.2.ebuild,v 1.1 2005/06/12 01:57:25 mcummings Exp $

inherit perl-module

DESCRIPTION="Command line interface to bugzilla"
HOMEPAGE="http://gentoo-bugger.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

DEPEND="${RDEPEND}"

RDEPEND="dev-perl/WWW-Mechanize
		dev-perl/config-general
		dev-perl/HTML-Strip
		dev-perl/TermReadKey"
