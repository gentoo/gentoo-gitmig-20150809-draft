# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmerlin/kmerlin-1.4.2.ebuild,v 1.1 2004/04/16 13:47:08 caleb Exp $

inherit kde

need-kde 3.1 # uses kpassivepopup.h

IUSE=""
DESCRIPTION="KDE MSN Messenger"
SRC_URI="mirror://sourceforge/kmerlin/${P}.tar.gz"
HOMEPAGE="http://kmerlin.olsd.de"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

PATCHES="${FILESDIR}/${P}-docbook.diff" # close bug #14285
