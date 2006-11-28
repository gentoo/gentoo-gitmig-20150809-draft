# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/tiblit/tiblit-2.0_beta.ebuild,v 1.4 2006/11/28 01:03:31 flameeyes Exp $

inherit kde
need-kde 3.2
KLV="20798"

DESCRIPTION="KDE style  focused on customization"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=${KLV}"
SRC_URI="mirror://sourceforge/${PN}/${P/_/-}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
S="${WORKDIR}/${P/_beta/}"
