# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/kdevmon/kdevmon-0.4.6.5.ebuild,v 1.3 2004/01/07 02:25:17 weeve Exp $

inherit kde-base

need-kde 3

S=${WORKDIR}/kdevmon-0.4.6
DESCRIPTION="Monitor bandwith usage with this KDE program."
SRC_URI="http://www.Informatik.Uni-Oldenburg.DE/~bigboss/kdevmon/${PN}-0.4.6-5.tar.gz"
HOMEPAGE="http://www.Informatik.Uni-Oldenburg.DE/~bigboss/kdevmon/"

LICENSE="GPL-2"
KEYWORDS="x86 sparc ~alpha"
