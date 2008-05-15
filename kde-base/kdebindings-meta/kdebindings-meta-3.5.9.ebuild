# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebindings-meta/kdebindings-meta-3.5.9.ebuild,v 1.2 2008/05/15 15:36:55 corsair Exp $

EAPI="1"
inherit kde-functions
DESCRIPTION="kdebindings - merge this to pull in all kdebindings-derived packages"
HOMEPAGE="http://www.kde.org/"

LICENSE="GPL-2"
SLOT="3.5"
KEYWORDS="~amd64 ~ppc ppc64 ~x86"
IUSE=""

# Unslotted packages aren't depended on via deprange
RDEPEND="
	>=kde-base/kalyptus-${PV}:${SLOT}
	>=kde-base/smoke-${PV}:${SLOT}
	>=kde-base/kdejava-${PV}:${SLOT}
	>=kde-base/qtjava-${PV}:${SLOT}
	>=kde-base/kjsembed-${PV}:${SLOT}
	~kde-base/dcopperl-$PV
	~kde-base/dcoppython-$PV"

# Broken and package.masked.
#	~kde-base/korundum-$PV
#	~kde-base/qtruby-$PV

# Omitted: qtsharp, dcopc, dcopjava, xparts (considered broken by upstream)
