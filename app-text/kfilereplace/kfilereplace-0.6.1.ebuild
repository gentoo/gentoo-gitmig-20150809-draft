# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/kfilereplace/kfilereplace-0.6.1.ebuild,v 1.1 2001/12/11 20:32:36 danarmak Exp $
. /usr/portage/eclass/inherit.eclass
inherit kde-base || die

DESCRIPTION="A multifile replace utility"
SRC_URI="http://download.sourceforge.net/kfilereplace/${P}.tar.bz2"
HOMEPAGE="http://kfilereplace.sourceforge.net"

DEPEND="$DEPEND sys-devel/perl"

need-kdelibs 2.1.1

