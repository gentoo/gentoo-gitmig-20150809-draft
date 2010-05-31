# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-MD5-File/Digest-MD5-File-0.07.ebuild,v 1.1 2010/05/31 09:31:44 tove Exp $

EAPI=3

MODULE_AUTHOR=DMUEY
inherit perl-module

DESCRIPTION="Perl extension for getting MD5 sums for files and urls."

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/libwww-perl"
DEPEND="${RDEPEND}"

SRC_TEST=do
