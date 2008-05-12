# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konq-plugins/konq-plugins-3.5.9.ebuild,v 1.5 2008/05/12 20:01:58 ranger Exp $

KMNAME=kdeaddons
KMNODOCS=true
EAPI="1"
inherit kde-meta

DESCRIPTION="Various plugins for Konqueror."
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND="|| ( >=kde-base/konqueror-${PV}:${SLOT} >=kde-base/kdebase-${PV}:${SLOT} )
	!kde-misc/metabar"
RDEPEND="${DEPEND}
>=kde-base/kdeaddons-docs-konq-plugins-${PV}:${SLOT}"

# Don't install the akregator plugin, since it depends on akregator, which is
# a heavy dep.
KMEXTRACTONLY="konq-plugins/akregator"

# Fixes a parallel make issue (bug 112214)
PATCHES="${FILESDIR}/${PN}-parallel-make.patch"
