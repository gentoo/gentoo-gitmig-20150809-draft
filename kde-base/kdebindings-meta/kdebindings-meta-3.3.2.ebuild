# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-meta/kdebindings-meta-3.3.2.ebuild,v 1.4 2005/02/11 14:09:44 danarmak Exp $
MAXKDEVER=3.3.2

inherit kde-functions
DESCRIPTION="kdebindings - merge this to pull in all kdebase-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.3"
KEYWORDS="x86"
IUSE=""

RDEPEND="
$(deprange 3.3.1 $PV kde-base/dcopc)
$(deprange 3.3.1 $PV kde-base/dcopperl)
$(deprange 3.3.1 $PV kde-base/dcoppython)
$(deprange $PV $MAXKDEVER kde-base/kalyptus)
$(deprange 3.3.1 $PV kde-base/kdejava)
$(deprange 3.3.1 $PV kde-base/kjsembed)
$(deprange $PV $MAXKDEVER kde-base/korundum)
$(deprange $PV $MAXKDEVER kde-base/qtjava)
$(deprange $PV $MAXKDEVER kde-base/qtruby)
$(deprange 3.3.1 $PV kde-base/smoke)"


# Omitted: qtsharp, dcopjava, xparts (considered broken by upstream) 