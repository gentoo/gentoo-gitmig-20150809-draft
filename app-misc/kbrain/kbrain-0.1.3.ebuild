# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kbrain/kbrain-0.1.3.ebuild,v 1.6 2002/10/04 04:55:47 vapier Exp $

. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die
S="${WORKDIR}/kbrain-${PV}"
need-kde 3.0 

DESCRIPTION="handy program to create Mind Maps"
SRC_URI="http://cmjartan.freezope.org/kbrain/files/${P}.tar.gz"
HOMEPAGE="http://cmjartan.freezope.org/kbrain"


LICENSE="GPL-2"
KEYWORDS="x86"
