# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/kcheckgmail/kcheckgmail-0.5.3a.ebuild,v 1.2 2005/02/22 10:59:52 blubb Exp $

inherit kde

DESCRIPTION="Gmail notifier applet for kde"
HOMEPAGE="http://sourceforge.net/projects/kcheckgmail"
SRC_URI="mirror://sourceforge/kcheckgmail/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

need-kde 3.2

src_unpack() {
	kde_src_unpack
	#upstream didn't regenerated the Makefile.in after a Makefile.am change, recreating.
	cd ${S}
	rm ${S}/configure
}
