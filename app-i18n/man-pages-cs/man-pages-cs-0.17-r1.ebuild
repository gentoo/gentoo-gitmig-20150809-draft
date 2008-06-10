# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-cs/man-pages-cs-0.17-r1.ebuild,v 1.1 2008/06/10 01:44:31 darkside Exp $

DESCRIPTION="A somewhat comprehensive collection of Linux czech man page translations"
HOMEPAGE="http://www.win.tue.nl/~aeb/linux/man/"
MY_PV="20080113"
SRC_URI="ftp://ftp.linux.cz/pub/linux/localization/czman/${P}.${MY_PV}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

RDEPEND="virtual/man"

src_compile() {
	make latest || die "make latest failed"
	make DESTDIR="${D}" || die "make DESTDIR failed"
	echo "done"
}

src_install() {
	emake install DESTDIR="${D}" || die
	#make MANDIR="${D}"/usr/share/man/cs install || die
	dodoc CONTRIB README*

	# remove man pages that are provided by other packages.
	# - sys-apps/shadow +nls
	# - sys-apps/man
	rm -f "${D}"/usr/share/man/cs/man1/{chfn,chsh,newgrp,su,passwd,groups,man}.1
	rm -f "${D}"/usr/share/man/cs/man1/{groups,su}.1 #224615
	rm -f "${D}"/usr/share/man/cs/man5/shadow.5
	rm -f "${D}"/usr/share/man/cs/man8/{lastlog,vigr,vipw}.8
}
