# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Dump-Streamer/Data-Dump-Streamer-2.09.ebuild,v 1.1 2009/06/23 07:37:46 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="YVES"

inherit perl-module

DESCRIPTION="Accurately serialize a data structure as Perl code"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/B-Utils-0.07"
RDEPEND="${DEPEND}"
