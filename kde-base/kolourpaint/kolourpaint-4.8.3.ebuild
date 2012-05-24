# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-4.8.3.ebuild,v 1.4 2012/05/24 09:23:54 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Paint Program for KDE"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
LICENSE="BSD LGPL-2"
IUSE="debug scanner"

DEPEND="media-libs/qimageblitz"
RDEPEND="${DEPEND}
	scanner? ( kde-base/ksaneplugin )"
