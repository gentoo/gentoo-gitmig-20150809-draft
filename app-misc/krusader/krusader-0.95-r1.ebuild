# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Karl Trygve Kalleberg <karltk@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-0.95-r1.ebuild,v 1.1 2001/10/03 22:20:18 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

DESCRIPTION="A Filemanager for KDE"
SRC_URI="http://krusader.sourceforge.net/distributions/${P}-1.tar.gz"
HOMEPAGE="http:/krusader.sourceforge.net/"

DEPEND="$DEPEND >=kde-base/kdelibs-2.0"
RDEPEND="$RDEPEND >=kde-base/kdelibs-2.0"

