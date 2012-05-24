# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdf/kdf-4.8.3.ebuild,v 1.4 2012/05/24 08:54:03 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE free disk space utility"
KEYWORDS="amd64 ~ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

src_unpack() {
	kde4-base_src_unpack
}
