# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Perlbal-XS-HTTPHeaders/Perlbal-XS-HTTPHeaders-0.20.ebuild,v 1.1 2010/03/27 23:48:25 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=DORMANDO
inherit perl-module

DESCRIPTION="XS acceleration for Perlbal header processing"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-perl/Perlbal"
mydoc="Changes README"
