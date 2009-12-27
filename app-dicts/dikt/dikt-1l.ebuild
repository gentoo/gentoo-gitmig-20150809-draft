# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/dikt/dikt-1l.ebuild,v 1.1 2009/12/27 12:09:18 ssuominen Exp $

EAPI=2
inherit kde4-base

DESCRIPTION="A dictionary for KDE"
HOMEPAGE="http://sites.google.com/site/diktv1/"
SRC_URI="http://sites.google.com/site/diktv1/${P}.tbz"

LICENSE="BSD-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="!kde-misc/dikt"

DOCS="README"
