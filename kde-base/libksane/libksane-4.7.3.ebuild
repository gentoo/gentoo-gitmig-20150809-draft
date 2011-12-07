# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libksane/libksane-4.7.3.ebuild,v 1.3 2011/12/07 22:13:53 hwoarang Exp $

EAPI=4

KDE_SCM="git"
inherit kde4-base

DESCRIPTION="SANE Library interface for KDE"
HOMEPAGE="http://www.kipi-plugins.org"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"
LICENSE="LGPL-2"

DEPEND="
	media-gfx/sane-backends
"
RDEPEND="${DEPEND}"
