# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/qtruby/qtruby-3.5.9.ebuild,v 1.3 2008/05/16 07:02:25 corsair Exp $

KMNAME=kdebindings
KMCOPYLIB="libsmokeqt smoke/qt"
KM_MAKEFILESREV=1
EAPI="1"
inherit kde-meta

DESCRIPTION="Ruby bindings for QT"
HOMEPAGE="http://developer.kde.org/language-bindings/ruby/"
KEYWORDS="~amd64 ~ppc ppc64 ~sparc ~x86"
IUSE=""

DEPEND="
	dev-ruby/rubygems
	>=kde-base/smoke-${PV}:${SLOT}
	>=virtual/ruby-1.8"
RDEPEND="${DEPEND}"

PATCHES="${FILESDIR}/no-gtk-glib-check.diff"

# Because this installs into /usr/lib/ruby/..., it doesn't have SLOT=X.Y like the rest of KDE,
# and it installs into /usr entirely.
# Note that it still depends on a specific range of (slotted) smoke versions.
SLOT="0"

src_compile() {
	kde_src_compile myconf
	myconf="$myconf --prefix=/usr"
	kde_src_compile configure make
}
