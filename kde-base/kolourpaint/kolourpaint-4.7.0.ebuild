# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-4.7.0.ebuild,v 1.2 2011/08/27 07:48:58 dilfridge Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="Paint Program for KDE"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="BSD LGPL-2"
IUSE="debug"

DEPEND="media-libs/qimageblitz"
RDEPEND=${DEPEND}
