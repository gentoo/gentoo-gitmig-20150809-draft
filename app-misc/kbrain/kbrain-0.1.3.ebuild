# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/kbrain/kbrain-0.1.3.ebuild,v 1.3 2002/07/11 06:30:16 drobbins Exp $

. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die
LICENSE="GPL-2"
S="${WORKDIR}/kbrain-${PV}"
need-kde 3.0 

DESCRIPTION="handy program to create Mind Maps"
SRC_URI="http://cmjartan.freezope.org/kbrain/files/${P}.tar.gz"
HOMEPAGE="http://cmjartan.freezope.org/kbrain"

