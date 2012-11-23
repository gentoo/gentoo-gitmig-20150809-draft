# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libksane/libksane-4.9.3.ebuild,v 1.3 2012/11/23 19:27:08 ago Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="SANE Library interface for KDE"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"
LICENSE="LGPL-2"

DEPEND="
	media-gfx/sane-backends
"
RDEPEND="${DEPEND}"
