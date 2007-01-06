# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xarchiver/xarchiver-0.4.6.ebuild,v 1.8 2007/01/06 18:55:40 nichoj Exp $

inherit xfce44

DESCRIPTION="Xfce4 archiver"
HOMEPAGE="http://xarchiver.xfce.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="7zip ace arj debug lha rar rpm zip"

DEPEND="dev-util/intltool
	>=x11-libs/gtk+-2.6
	>=dev-libs/glib-2.6"
RDEPEND="${DEPEND}
	zip? ( app-arch/unzip app-arch/zip )
	ace? ( app-arch/unace )
	rar? ( || ( app-arch/rar app-arch/unrar ) )
	7zip? ( app-arch/p7zip )
	rpm? ( app-arch/rpm )
	arj? ( || ( app-arch/arj app-arch/unarj ) )
	lha? ( app-arch/lha )"
