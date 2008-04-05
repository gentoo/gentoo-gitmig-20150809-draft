# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/libksane/libksane-0.1.0.ebuild,v 1.1 2008/04/05 16:51:37 philantrop Exp $

EAPI="1"

KDE_PV="4.0.3"
KDE_LINGUAS="be de el es et fr ga gl ja km lt lv nds nl oc pt pt_BR ro sk sv th
tr uk zh_CN"

SLOT="kde-4"
NEED_KDE=":${SLOT}"
inherit kde4-base

DESCRIPTION="libksane is a C++ library for SANE interface to control flat scanners"
HOMEPAGE="http://www.kde.org/"
LICENSE="LGPL-2"
SRC_URI="mirror://kde/stable/${KDE_PV}/src/extragear/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="debug"

PREFIX="${KDEDIR}"

RDEPEND="media-gfx/sane-backends"
DEPEND="${RDEPEND}
	sys-devel/gettext"
