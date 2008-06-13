# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-cs/man-pages-cs-0.17-r1.ebuild,v 1.4 2008/06/13 04:06:02 mr_bones_ Exp $

DESCRIPTION="A somewhat comprehensive collection of Linux czech man page translations"
HOMEPAGE="http://www.win.tue.nl/~aeb/linux/man/"
MY_PV="20080113"
SRC_URI="ftp://ftp.linux.cz/pub/linux/localization/czman/${P}.${MY_PV}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="virtual/man"

S="${WORKDIR}/${P}.${MY_PV}" #not sure if this is the best approach.

src_compile() {
	make DESTDIR="${D}" latest || die "make latest failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc CONTRIB README*

	# remove man pages that are provided by other packages.
	# - sys-apps/shadow +nls
	# - sys-apps/man
	rm -f "${D}"/usr/share/man/cs/man1/{chfn,chsh,newgrp,su,passwd,groups,man}.1
	rm -f "${D}"/usr/share/man/cs/man1/{groups,su}.1 #224615
	rm -f "${D}"/usr/share/man/cs/man5/shadow.5
	rm -f "${D}"/usr/share/man/cs/man8/{lastlog,vigr,vipw}.8
}
