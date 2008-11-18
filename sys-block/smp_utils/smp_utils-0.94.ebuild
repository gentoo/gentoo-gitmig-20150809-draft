# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/smp_utils/smp_utils-0.94.ebuild,v 1.1 2008/11/18 02:14:30 robbat2 Exp $

inherit eutils

DESCRIPTION="Utilities for SAS management protocol (SMP)"
HOMEPAGE="http://sg.danny.cz/sg/smp_utils.html"
SRC_URI="http://sg.danny.cz/sg/p/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	for i in Makefile */Makefile ; do
		sed -i \
			-e "/^CFLAGS/s:-g -O2:${CFLAGS}:g" \
			-e '/^PREFIX=/s:/local::' \
			-e '/^INSTDIR=/s:/bin:/sbin:' \
			-e 's:$(DESTDIR)/:$(DESTDIR):' \
			-e "/^LIBDIR=/s:/lib$:/$(get_libdir):" \
			-e '/^MANDIR=/s:)/man:)/share/man:' \
			-e 's:install -s :install :' \
			$i || die "sed of $i failed"
	done
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodoc AUTHORS ChangeLog COVERAGE CREDITS README* TODO
	dohtml doc/*html
	make install DESTDIR="${D}" || die "make install failed"
}
