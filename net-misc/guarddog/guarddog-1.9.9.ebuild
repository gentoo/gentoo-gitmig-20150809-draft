# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/guarddog/guarddog-1.9.9.ebuild,v 1.1 2001/12/22 22:38:43 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kdelibs 2.2
need-qt 2.2

S=${WORKDIR}/${P}
DESCRIPTION="Guarddog ${PV}"
SRC_URI="http://www.simonzone.com/software/guarddog/${P}.tar.gz"
HOMEPAGE="http://www.simonzone.com/software/guarddog/"

DEPEND="$DEPEND >=sys-apps/iptables-1.2.4"
RDEPEND="$RDEPEND >=sys-apps/iptables-1.2.4"
