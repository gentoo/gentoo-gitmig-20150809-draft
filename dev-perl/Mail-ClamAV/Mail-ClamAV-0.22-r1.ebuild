# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-ClamAV/Mail-ClamAV-0.22-r1.ebuild,v 1.5 2009/04/03 06:20:28 tove Exp $

EAPI=2

MODULE_AUTHOR=SABECK
inherit perl-module

DESCRIPTION="Perl extension for the clamav virus scanner."

SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

RDEPEND=">=app-antivirus/clamav-0.94
	dev-perl/Inline"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/0.22-clamav-0.94.patch )
SRC_TEST=do
MAKEOPTS="${MAKEOPTS} -j1"
