# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/arson/arson-0.9.5.ebuild,v 1.2 2002/05/12 20:01:32 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base

need-kde 3

export WANT_AUTOCONF_2_5=1
S=${WORKDIR}/${P}-kde3
DESCRIPTION="A KDE frontend to CD burning and CD ripping tools."
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/arson/${P}-kde3.tar.bz2"
HOMEPAGE="http://arson.sourceforge.net/"

newdepend ">=media-sound/cdparanoia-3.9.8
	   >=media-sound/bladeenc-0.94.2"
