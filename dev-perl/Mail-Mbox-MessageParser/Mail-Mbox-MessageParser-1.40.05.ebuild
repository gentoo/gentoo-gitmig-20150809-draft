# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Mbox-MessageParser/Mail-Mbox-MessageParser-1.40.05.ebuild,v 1.4 2006/10/21 14:21:07 dertobi123 Exp $

inherit versionator perl-module

MY_P="${PN}-$(delete_version_separator 2)"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Manipulation of electronic mail addresses"
SRC_URI="mirror://cpan/authors/id/D/DC/DCOPPIT/${MY_P}.tar.gz
	mirror://sourceforge/m-m-msgparser/${MY_P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/m-m-msgparser/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ia64 ppc sparc ~x86"

DEPEND="dev-perl/Text-Diff
	dev-perl/FileHandle-Unget
	dev-lang/perl"
