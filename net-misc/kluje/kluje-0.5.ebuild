# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kluje/kluje-0.5.ebuild,v 1.12 2005/01/15 00:09:54 danarmak Exp $

inherit kde

LICENSE="GPL-2"
DESCRIPTION="KLuJe - a client for the popular online journal site
LiveJournal."
SRC_URI="mirror://sourceforge/kluje/${P}.tar.gz"
HOMEPAGE="http://kluje.sourceforge.net/"
KEYWORDS="x86 sparc "
IUSE=""
DEPEND="|| ( kde-base/kdebase-meta >=kde-base/kdebase-3.0 )"

need-kde 3
