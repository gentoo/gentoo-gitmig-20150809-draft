# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-ShareDir/File-ShareDir-1.02.ebuild,v 1.1 2010/03/19 06:56:29 tove Exp $

EAPI=2

MODULE_AUTHOR="ADAMK"
inherit perl-module

DESCRIPTION="Locate per-dist and per-module shared files"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Class-Inspector"
DEPEND="${RDEPEND}"

SRC_TEST="do"

src_install(){
	find "${S}" \( -name "sample.txt" -o -name "test_file.txt" \) -delete
	perl-module_src_install
}
