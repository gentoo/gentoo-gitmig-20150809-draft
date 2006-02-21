# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/kbarcode/kbarcode-2.0.0_rc1.ebuild,v 1.1 2006/02/21 19:53:52 carlo Exp $

inherit kde

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A KDE 3.x solution for barcode handling."
HOMEPAGE="http://www.kbarcode.net/"
SRC_URI="mirror://sourceforge/kbarcode/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=app-text/barcode-0.98"

RDEPEND=">=app-text/barcode-0.98
	virtual/ghostscript"

need-kde 3.4
