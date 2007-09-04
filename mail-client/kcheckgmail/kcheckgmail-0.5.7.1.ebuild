# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/kcheckgmail/kcheckgmail-0.5.7.1.ebuild,v 1.1 2007/09/04 13:14:49 keytoaster Exp $

inherit kde

DESCRIPTION="Gmail notifier applet for kde"
HOMEPAGE="http://sourceforge.net/projects/kcheckgmail"
SRC_URI="mirror://sourceforge/kcheckgmail/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

need-kde 3.2

src_unpack() {
	kde_src_unpack

	# The tarball was not created in a clean way.
	rm -f "${S}/configure"
}
