# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-ClamAV/Mail-ClamAV-0.29.ebuild,v 1.1 2009/05/01 10:29:18 tove Exp $

EAPI=2

MODULE_AUTHOR=CONVERTER
inherit perl-module

DESCRIPTION="Perl extension for the clamav virus scanner"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

RDEPEND=">=app-antivirus/clamav-0.95.1
	dev-perl/Inline"
DEPEND="${RDEPEND}"

SRC_TEST=do
MAKEOPTS="${MAKEOPTS} -j1"
