# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/kift/kift-0.7.0.ebuild,v 1.1 2001/12/07 13:00:37 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kdelibs 2.1

S=${WORKDIR}/${P}

DESCRIPTION="KDE interface for giFT"
HOMEPAGE="http://kift.sourceforge.net"

DEPEND="$DEPEND >=net-misc/gift-0.9.7"

SRC_URI="http://prdownloads.sourceforge.net/kift/${P}.tar.gz"
