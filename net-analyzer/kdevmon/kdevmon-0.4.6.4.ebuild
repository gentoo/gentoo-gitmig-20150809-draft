# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Christophe Vanfleteren <c.vanfleteren@pandora.be>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/kdevmon/kdevmon-0.4.6.4.ebuild,v 1.3 2002/07/01 21:33:31 danarmak Exp $

inherit kde-base || die

need-kde 3

LICENSE="GPL-2"
S=${WORKDIR}/kdevmon-0.4.6
DESCRIPTION="Monitor bandwith usage with this KDE program."
SRC_URI="http://www.Informatik.Uni-Oldenburg.DE/~bigboss/kdevmon/${PN}-0.4.6-4.tar.gz"
HOMEPAGE="http://www.Informatik.Uni-Oldenburg.DE/~bigboss/kdevmon/"

newdepend ">=kde-base/kdebase-3"


