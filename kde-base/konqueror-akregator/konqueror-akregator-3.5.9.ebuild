# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror-akregator/konqueror-akregator-3.5.9.ebuild,v 1.2 2008/03/04 06:58:14 jer Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="konq-plugins/akregator"
EAPI="1"
inherit kde-meta

DESCRIPTION="konqueror's akregator plugin"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=kde-base/konqueror-${PV}:${SLOT}"
RDEPEND="${DEPEND}
>=kde-base/kdeaddons-docs-konq-plugins-${PV}:${SLOT}
>=kde-base/akregator-${PV}:${SLOT}"
