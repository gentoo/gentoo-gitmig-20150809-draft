# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/keurocalc/keurocalc-1.1.0.ebuild,v 1.1 2011/04/20 21:02:49 scarabeus Exp $

EAPI=4
KDE_LINGUAS="ar bg br ca ca@valencia cs da de el en_GB es et fr ga gl hu it ja
ka nb nds nl pl pt pt_BR ru sk sr@Latn sr sv ta tr uk zh_TW"
KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="A universal currency converter and calculator"
HOMEPAGE="http://opensource.bureau-cornavin.com/keurocalc/index.html"
SRC_URI="http://opensource.bureau-cornavin.com/keurocalc/sources/${P}.tgz"

LICENSE="GPL-2 FDL-1.2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DOCS=( AUTHORS ChangeLog README TODO )
