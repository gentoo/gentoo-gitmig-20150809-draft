# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/kdevmon/kdevmon-0.4.6.5.ebuild,v 1.4 2004/03/14 17:24:29 mr_bones_ Exp $

inherit kde

need-kde 3

S=${WORKDIR}/kdevmon-0.4.6
DESCRIPTION="Monitor bandwith usage with this KDE program."
SRC_URI="http://www.Informatik.Uni-Oldenburg.DE/~bigboss/kdevmon/${PN}-0.4.6-5.tar.gz"
HOMEPAGE="http://www.Informatik.Uni-Oldenburg.DE/~bigboss/kdevmon/"

LICENSE="GPL-2"
KEYWORDS="x86 sparc ~alpha"
