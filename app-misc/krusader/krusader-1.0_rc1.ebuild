# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Authors Karl Trygve Kalleberg <karltk@gentoo.org>, Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-misc/krusader/krusader-1.0_rc1.ebuild,v 1.2 2001/12/23 21:35:15 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

S="${WORKDIR}/krusader-0.99-RC1"
need-kde 2.1

DESCRIPTION="An oldschool Filemanager for KDE"
SRC_URI="http://krusader.sourceforge.net/distributions/krusader-rc1.tar.gz"
HOMEPAGE="http:/krusader.sourceforge.net/"

