# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/kst/kst-0.94.ebuild,v 1.3 2004/03/23 02:47:17 weeve Exp $

inherit kde
need-kde 3.1

DESCRIPTION="A plotting and data viewing program for KDE"
SRC_URI="http://omega.astro.utoronto.ca/kst/${PN}-${PV}.tar.gz"
HOMEPAGE="http://omega.astro.utorona.ca/kst/"

KEYWORDS="x86 ~ppc ~sparc"
LICENSE="GPL-2"
SLOT="0"
DEPEND=">=kde-base/kdebase-3.1"

