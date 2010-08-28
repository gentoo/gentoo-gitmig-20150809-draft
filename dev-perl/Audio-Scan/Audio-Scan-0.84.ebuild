# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-Scan/Audio-Scan-0.84.ebuild,v 1.1 2010/08/28 07:22:59 tove Exp $

EAPI=2

MODULE_AUTHOR=AGRUNDMA
inherit perl-module

DESCRIPTION="Fast C metadata and tag reader for all common audio file formats"

LICENSE="|| ( GPL-2 GPL-3 )" # GPL-2+
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
#	test? ( dev-perl/Test-Pod
#		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
