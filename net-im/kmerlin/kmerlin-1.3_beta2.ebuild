# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmerlin/kmerlin-1.3_beta2.ebuild,v 1.3 2003/07/13 12:44:50 aliz Exp $
inherit kde-base

need-kde 3

IUSE=""
MY_P=${P/_b/B}
DESCRIPTION="KDE MSN Messenger"
SRC_URI="mirror://sourceforge/kmerlin/${MY_P}.tar.gz"
HOMEPAGE="http://kmerlin.olsd.de"
S=${WORKDIR}/${MY_P}
LICENSE="GPL-2"
KEYWORDS="x86"
