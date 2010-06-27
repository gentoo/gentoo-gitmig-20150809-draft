# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CDDB/CDDB-1.22.0.ebuild,v 1.4 2010/06/27 19:00:20 nixnut Exp $

EAPI=2

inherit versionator
MODULE_AUTHOR=RCAPUTO
MY_P=${PN}-$(get_major_version).$(delete_all_version_separators $(get_after_major_version))
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="high-level interface to cddb/freedb protocol"

SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""

SRC_TEST=no
