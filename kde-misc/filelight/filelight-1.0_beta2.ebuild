# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/filelight/filelight-1.0_beta2.ebuild,v 1.1 2004/10/30 18:00:42 carlo Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Filelight is a tool to display where the space is used on the harddisk"
HOMEPAGE="http://www.methylblue.com/filelight/"
SRC_URI="http://www.methylblue.com/filelight/${MY_P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="arts"

need-kde 3

src_compile() {
	local myconf

	use arts || myconf="${myconf} --without-arts"

	kde_src_compile all
}
