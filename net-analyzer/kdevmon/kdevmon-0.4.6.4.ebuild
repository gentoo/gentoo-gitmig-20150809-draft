# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/kdevmon/kdevmon-0.4.6.4.ebuild,v 1.14 2004/02/22 22:35:09 agriffis Exp $

inherit kde-base

need-kde 3

S=${WORKDIR}/kdevmon-0.4.6
DESCRIPTION="Monitor bandwith usage with this KDE program."
SRC_URI="http://www.Informatik.Uni-Oldenburg.DE/~bigboss/kdevmon/${PN}-0.4.6-4.tar.gz"
HOMEPAGE="http://www.Informatik.Uni-Oldenburg.DE/~bigboss/kdevmon/"

newdepend ">=kde-base/kdebase-3"


LICENSE="GPL-2"
KEYWORDS="x86 sparc ppc"
