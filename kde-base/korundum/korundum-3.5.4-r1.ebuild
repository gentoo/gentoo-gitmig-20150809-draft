# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/korundum/korundum-3.5.4-r1.ebuild,v 1.1 2006/08/29 20:17:05 caleb Exp $

KMNAME=kdebindings
KMCOPYLIB="libsmokeqt smoke/qt libsmokekde smoke/kde"
KMCOMPILEONLY="qtruby"
KM_MAKEFILESREV=1
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE ruby bindings"
HOMEPAGE="http://developer.kde.org/language-bindings/ruby/"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
OLDDEPEND=">=virtual/ruby-1.8 ~kde-base/qtruby-$PV ~kde-base/smoke-3.3.1"
DEPEND=" >=virtual/ruby-1.8
$(deprange $PV $MAXKDEVER kde-base/qtruby)
$(deprange 3.5.2 $MAXKDEVER kde-base/smoke)"

PATCHES="$FILESDIR/no-gtk-glib-check.diff $FILESDIR/qtruby-3.5.4-more.patch $FILESDIR/korundum-3.5.4-more.patch" 

# Because this installs into /usr/lib/ruby/..., it doesn't have SLOT=X.Y like the rest of KDE,
# and it installs into /usr entirely.
# Note that it still depends on a specific range of (slotted) smoke and qtruby versions.
SLOT="0"
src_compile() {
	kde_src_compile myconf
	myconf="$myconf --prefix=/usr"
	kde_src_compile configure make
}

