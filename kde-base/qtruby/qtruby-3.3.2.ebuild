# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/qtruby/qtruby-3.3.2.ebuild,v 1.1 2004/12/25 15:51:02 danarmak Exp $

KMNAME=kdebindings
KMCOPYLIB="libsmokeqt smoke/qt"
KM_MAKEFILESREV=1
MAXKDEVER=3.3.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Ruby bindings for QT"
KEYWORDS="~x86"
IUSE=""
OLDDEPEND=">=virtual/ruby-1.8 ~kde-base/smoke-3.3.1"
DEPEND=" >=virtual/ruby-1.8
$(deprange 3.3.1 $PV kde-base/smoke)"

PATCHES="$FILESDIR/no-gtk-glib-check.diff"

