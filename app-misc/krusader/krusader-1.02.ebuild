# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Authors Karl Trygve Kalleberg <karltk@gentoo.org>, Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.02.ebuild,v 1.2 2002/05/21 18:14:06 danarmak Exp $

inherit kde-base || die

need-kde 3

DESCRIPTION="An oldschool Filemanager for KDE"
SRC_URI="http://krusader.sourceforge.net/stable/${P}.tar.gz"
HOMEPAGE="http:/krusader.sourceforge.net/"

