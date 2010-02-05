# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Safe-World/Safe-World-0.14.ebuild,v 1.1 2010/02/05 16:14:26 weaver Exp $

EAPI=2

MODULE_AUTHOR=GMPASSOS

inherit perl-module

DESCRIPTION="Create multiple virtual instances of a Perl interpreter that can be assembled together"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/Hash-NoRef"
RDEPEND="${DEPEND}"
