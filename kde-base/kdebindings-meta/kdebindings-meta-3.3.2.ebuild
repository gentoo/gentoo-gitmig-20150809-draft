# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-meta/kdebindings-meta-3.3.2.ebuild,v 1.6 2005/02/19 15:37:14 danarmak Exp $
MAXKDEVER=3.3.2

inherit kde-functions
DESCRIPTION="kdebindings - merge this to pull in all kdebindings-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.3"
KEYWORDS="x86"
IUSE=""

RDEPEND="
$(deprange 3.3.1 $PV kde-base/dcopc)
>=kde-base/dcopperl-3.3.1
>=kde-base/dcoppython-3.3.1
$(deprange $PV $MAXKDEVER kde-base/kalyptus)
$(deprange 3.3.1 $PV kde-base/kdejava)
$(deprange 3.3.1 $PV kde-base/kjsembed)
>=kde-base/korundum-$PV
$(deprange $PV $MAXKDEVER kde-base/qtjava)
>=kde-base/qtruby-$PV
$(deprange 3.3.1 $PV kde-base/smoke)"


# Omitted: qtsharp, dcopjava, xparts (considered broken by upstream) 
