# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Mbox-MessageParser/Mail-Mbox-MessageParser-1.500.200.ebuild,v 1.3 2011/01/22 17:03:36 fauli Exp $

EAPI=2

MODULE_AUTHOR=DCOPPIT
MODULE_VERSION=1.5002
inherit perl-module

DESCRIPTION="Manipulation of electronic mail addresses"
HOMEPAGE="http://sourceforge.net/projects/m-m-msgparser/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

DEPEND="dev-perl/Text-Diff
	dev-perl/FileHandle-Unget"
RDEPEND="${DEPEND}"

SRC_TEST=do
PATCHES=( "${FILESDIR}"/${PV}-warning.patch )
