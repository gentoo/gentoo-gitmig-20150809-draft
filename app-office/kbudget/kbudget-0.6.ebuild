# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kbudget/kbudget-0.6.ebuild,v 1.10 2006/12/20 01:00:56 masterdriverz Exp $

inherit kde
need-kde 3.0

DESCRIPTION="A budgeting and money management program for KDE."
SRC_URI="http://www.garandnet.net/kbudget/downloads/${P}.tar.bz2"
HOMEPAGE="http://www.garandnet.net/kbudget/"

LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc sparc x86"

SLOT="0"
IUSE="kdeenablefinal"
