# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/kcheckgmail/kcheckgmail-0.5.5.ebuild,v 1.2 2006/03/30 04:24:30 tsunam Exp $

inherit kde

DESCRIPTION="Gmail notifier applet for kde"
HOMEPAGE="http://sourceforge.net/projects/kcheckgmail"
SRC_URI="mirror://sourceforge/kcheckgmail/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~sparc x86"
IUSE=""

need-kde 3.2

src_unpack() {
	kde_src_unpack

	# The tarball was not created in a clean way.
	make -f admin/Makefile.common || die
}
