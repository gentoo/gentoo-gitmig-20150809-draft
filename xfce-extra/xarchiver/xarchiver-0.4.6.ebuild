# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xarchiver/xarchiver-0.4.6.ebuild,v 1.10 2007/01/23 21:13:56 welp Exp $

inherit xfce44

DESCRIPTION="Xfce4 archiver"
HOMEPAGE="http://xarchiver.xfce.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="7zip arj debug lha rar zip"

RDEPEND=">=x11-libs/gtk+-2.6
	>=dev-libs/glib-2.6
	zip? ( app-arch/unzip app-arch/zip )
	rar? ( || ( app-arch/rar app-arch/unrar ) )
	7zip? ( app-arch/p7zip )
	arj? ( || ( app-arch/arj app-arch/unarj ) )
	lha? ( app-arch/lha )"
DEPEND="${RDEPEND}
	dev-util/intltool"
