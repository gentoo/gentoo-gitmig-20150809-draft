# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/choqok/choqok-0.9.85.ebuild,v 1.1 2010/08/21 14:38:23 tampakrap Exp $

EAPI="2"

KDE_LINGUAS="bg cs da de el en_GB eo es et fi fr ga gl hr hu is ja km lt ms nb
			nds nl pa pl pt pt_BR ro ru sk sv tr uk zh_CN zh_TW"

inherit kde4-base

DESCRIPTION="A Free/Open Source micro-blogging client for KDE"
HOMEPAGE="http://choqok.gnufolks.org/"
SRC_URI="http://d10xg45o6p6dbl.cloudfront.net/projects/c/choqok/${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="4"
IUSE="debug"

DEPEND="dev-libs/qjson
		>=dev-libs/qoauth-1.0.1"
RDEPEND="${DEPEND}"
