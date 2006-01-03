# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.9_beta2.ebuild,v 1.1 2006/01/03 19:24:21 carlo Exp $

inherit kde

MY_P="${P/_beta/b}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A Latex Editor and TeX shell for kde"
HOMEPAGE="http://kile.sourceforge.net/"
SRC_URI="mirror://sourceforge/kile/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT=0
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="kde"

RDEPEND="dev-lang/perl
	virtual/tetex
	kde? ( || ( ( kde-base/kpdf
	              kde-base/kghostview
	              kde-base/kdvi
	              kde-base/kviewshell )
	            kde-base/kdegraphics ) )"

need-kde 3.2
