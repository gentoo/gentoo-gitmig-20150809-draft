# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-meta/kdebindings-meta-3.3.1.ebuild,v 1.1 2004/11/06 17:23:32 danarmak Exp $

DESCRIPTION="kdebindings 3.3.1 - merge this to pull in all kdebase-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.3"
KEYWORDS="~x86"
IUSE=""

RDEPEND="
~kde-base/dcopc-${PV}
~kde-base/dcopperl-${PV}
~kde-base/dcoppython-${PV}
~kde-base/kalyptus-${PV}
~kde-base/kdejava-${PV}
~kde-base/kjsembed-${PV}
~kde-base/korundum-${PV}
~kde-base/qtjava-${PV}
~kde-base/qtruby-${PV}
~kde-base/smoke-${PV}"


# Omitted: qtsharp, dcopjava, xparts (considered broken by upstream) 