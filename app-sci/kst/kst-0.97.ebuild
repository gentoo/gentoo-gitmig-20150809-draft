# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/kst/kst-0.97.ebuild,v 1.3 2004/06/06 16:56:27 kugelfang Exp $

inherit kde
need-kde 3.1

DESCRIPTION="A plotting and data viewing program for KDE"
SRC_URI="http://omega.astro.utoronto.ca/kst/${P}.tar.gz"
HOMEPAGE="http://omega.astro.utoronto.ca/kst/"

KEYWORDS="~x86 ~ppc ~sparc amd64"
LICENSE="GPL-2"

SLOT="0"
IUSE=""

DEPEND=">=kde-base/kdebase-3.1"

