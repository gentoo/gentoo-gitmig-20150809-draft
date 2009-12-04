# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/keurocalc/keurocalc-1.0.2.ebuild,v 1.1 2009/12/04 12:17:21 ssuominen Exp $

EAPI=2
KDE_LINGUAS="ar bg br cs da de el en_GB es et fr ga gl hu it ja ka nb nl pl pt_BR
pt sr@Latn sr sv ta tr"
inherit kde4-base

DESCRIPTION="A universal currency converter and calculator"
HOMEPAGE="http://opensource.bureau-cornavin.com/keurocalc/index.html"
SRC_URI="http://opensource.bureau-cornavin.com/keurocalc/sources/${P}.tgz"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DOCS="AUTHORS ChangeLog README TODO"
