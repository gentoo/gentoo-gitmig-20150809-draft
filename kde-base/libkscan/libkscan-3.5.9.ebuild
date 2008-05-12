# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkscan/libkscan-3.5.9.ebuild,v 1.3 2008/05/12 17:25:31 armin76 Exp $

KMNAME=kdegraphics
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="KDE scanner library"
KEYWORDS="alpha ~amd64 ia64 ~ppc ~ppc64 sparc ~x86"
LICENSE="LGPL-2"
IUSE=""

DEPEND="media-gfx/sane-backends"
RDEPEND="${DEPEND}"
