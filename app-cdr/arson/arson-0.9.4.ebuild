# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/arson/arson-0.9.4.ebuild,v 1.3 2002/04/13 16:43:38 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base

need-kde 2.2

S=${WORKDIR}/${P}
DESCRIPTION="A KDE frontend to CD burning and CD ripping tools."
SRC_URI="http://telia.dl.sourceforge.net/arson/${P}.tar.bz2"
HOMEPAGE="http://arson.sourceforge.net/"
