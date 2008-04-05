# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kio_gopher/kio_gopher-0.1.0.ebuild,v 1.1 2008/04/05 16:51:14 philantrop Exp $

EAPI="1"

KDE_LINGUAS="ar bg br ca cs cy da de el en_GB es et fr ga gl is it ka lt ms nl
pa pl pt pt_BR ro rw sk sr sv ta tr uk"

KDE_PV="4.0.3"
SLOT="kde-4"
NEED_KDE=":${SLOT}"
inherit kde4-base

DESCRIPTION="Konqueror support for the gopher:// protocol"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/${KDE_PV}/src/extragear/${P}.tar.bz2"

KEYWORDS="~amd64 ~x86"
IUSE="debug"

PREFIX="${KDEDIR}"

RDEPEND=""
DEPEND="${RDEPEND}
	sys-devel/gettext"
