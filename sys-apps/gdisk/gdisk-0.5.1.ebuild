# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gdisk/gdisk-0.5.1.ebuild,v 1.1 2009/12/06 22:40:24 alexxy Exp $

EAPI="2"

inherit eutils

DESCRIPTION="gdisk - GPT partition table manipulator for Linux"
HOMEPAGE="http://www.rodsbooks.com/gdisk/"
SRC_URI="mirror://sourceforge/gptfdisk/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""

src_install()
{
	dosbin gdisk || die
	doman gdisk.8 || die
}
