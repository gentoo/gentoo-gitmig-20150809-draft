# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-meta/kdebindings-meta-3.4.0_beta1.ebuild,v 1.3 2005/02/06 13:39:54 danarmak Exp $
MAXKDEVER=$PV

inherit kde-functions
DESCRIPTION="kdebindings - merge this to pull in all kdebase-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.4"
KEYWORDS="~x86"
IUSE=""

RDEPEND="
$(deprange $PV $MAXKDEVER kde-base/dcopperl)
$(deprange $PV $MAXKDEVER kde-base/dcoppython)
$(deprange $PV $MAXKDEVER kde-base/kalyptus)
$(deprange $PV $MAXKDEVER kde-base/kdejava)
$(deprange $PV $MAXKDEVER kde-base/kjsembed)
$(deprange $PV $MAXKDEVER kde-base/korundum)
$(deprange $PV $MAXKDEVER kde-base/qtjava)
$(deprange $PV $MAXKDEVER kde-base/qtruby)
$(deprange $PV $MAXKDEVER kde-base/smoke)"


# Omitted: qtsharp, dcopc, dcopjava, xparts (considered broken by upstream) 