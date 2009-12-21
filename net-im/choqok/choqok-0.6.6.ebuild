# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/choqok/choqok-0.6.6.ebuild,v 1.2 2009/12/21 20:32:40 tampakrap Exp $

EAPI="2"

KDE_LINGUAS="bg cs de el en_GB et ga gl km lt nds nl pt pt_BR ro ru sk sv tr uk zh_CN"
inherit kde4-base

DESCRIPTION="A Free/Open Source micro-blogging client for KDE"
HOMEPAGE="http://choqok.gnufolks.org/"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/95760-${P}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="6"
IUSE="debug"
