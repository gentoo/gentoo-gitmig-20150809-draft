# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/korundum/korundum-3.3.2.ebuild,v 1.2 2005/02/05 11:39:22 danarmak Exp $

KMNAME=kdebindings
KMCOPYLIB="libsmokeqt smoke/qt libsmokekde smoke/kde"
KMCOMPILEONLY="qtruby"
KM_MAKEFILESREV=1
MAXKDEVER=3.3.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE ruby bindings"
KEYWORDS="~x86"
IUSE=""
OLDDEPEND=">=virtual/ruby-1.8 ~kde-base/qtruby-$PV ~kde-base/smoke-3.3.1"
DEPEND=" >=virtual/ruby-1.8
$(deprange $PV $MAXKDEVER kde-base/qtruby)
$(deprange 3.3.1 $PV kde-base/smoke)"

PATCHES="$FILESDIR/no-gtk-glib-check.diff"


