# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/arson/arson-0.9.1.ebuild,v 1.1 2002/01/07 23:42:09 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 2.1

DESCRIPTION="A KDE frontend to CD burning and CD ripping tools."
SRC_URI="http://telia.dl.sourceforge.net/arson/${P}.tar.bz2"
HOMEPAGE="http://arson.sourceforge.net/"
