# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/blogilo/blogilo-1.0.ebuild,v 1.1 2010/01/02 18:13:12 ssuominen Exp $

EAPI=2
KDE_LINGUAS="ar cs de en_CA es et fa fr he it ms nl pl pt pt_BR ru sv tr uk
zh_CN"
inherit kde4-base

DESCRIPTION="A powerful KDE blogging client"
HOMEPAGE="http://blogilo.gnufolks.org/"
SRC_URI="http://blogilo.gnufolks.org/packages/bilbo-${PV}-src.tar.gz"

LICENSE="GPL-3 LGPL-2.1"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/kdepimlibs-${KDE_MINIMAL}
	!${CATEGORY}/${PN}:0"

S=${WORKDIR}/bilbo

DOCS="AUTHORS CHANGELOG README TODO"
