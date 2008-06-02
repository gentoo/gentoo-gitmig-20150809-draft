# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/plonepopoll/plonepopoll-2.6.1.ebuild,v 1.1 2008/06/02 10:41:03 tupone Exp $

inherit versionator zproduct

MY_PN="PlonePopoll"
MY_PV=$(replace_all_version_separators -)
MY_P=${PN}-${MY_PV}
DESCRIPTION="Plone product which provides multiple choice polls"
HOMEPAGE="http://plone.org/products/plonepopoll/"
SRC_URI="${HOMEPAGE}releases/${PV}/${MY_P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

DEPEND="=net-zope/plone-2.5*"

ZPROD_LIST="${MY_PN}"
