# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kluje/kluje-0.6.ebuild,v 1.5 2002/12/09 04:33:16 manson Exp $

inherit kde-base

LICENSE="GPL-2"
DESCRIPTION="KLuJe - a client for the popular online journal site
LiveJournal."
SRC_URI="mirror://sourceforge/kluje/${P}.tar.gz"
HOMEPAGE="http://kluje.sourceforge.net/"
KEYWORDS="x86 sparc "
DEPEND=">=kde-base/kdebase-3.0"

need-kde 3

