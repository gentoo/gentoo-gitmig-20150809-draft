# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Christophe Vanfleteren <c.vanfleteren@pandora.be>

. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 3

S=${WORKDIR}/kdevmon-0.4.6
DESCRIPTION="Monitor bandwith usage with this KDE program."
SRC_URI="http://www.Informatik.Uni-Oldenburg.DE/~bigboss/kdevmon/${PN}-0.4.6-4.tar.gz"
HOMEPAGE="http://www.Informatik.Uni-Oldenburg.DE/~bigboss/kdevmon/"

newdepend ">=kde-base/kdebase-3"


