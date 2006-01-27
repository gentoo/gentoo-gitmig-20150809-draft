# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zsyncer/zsyncer-0.6.1.ebuild,v 1.2 2006/01/27 02:53:59 vapier Exp $

inherit zproduct

MY_P="ZSyncer-${PV}"
DESCRIPTION="ZSyncer allows live zope objects to be synchronized from one Zope to another"
HOMEPAGE="http://zsyncer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="ZPL"
KEYWORDS="~x86"

DEPEND=">=net-zope/zope-2.7"

ZPROD_LIST="ZSyncer"
