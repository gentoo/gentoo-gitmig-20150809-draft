# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/qtruby/qtruby-3.3.1.ebuild,v 1.1 2004/11/06 17:23:33 danarmak Exp $

KMNAME=kdebindings
KMCOPYLIB="libsmokeqt smoke/qt"
inherit kde-meta

DESCRIPTION="Ruby bindings for QT"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=virtual/ruby-1.8 ~kde-base/smoke-$PV"
PATCHES="$FILESDIR/no-gtk-glib-check.diff"

