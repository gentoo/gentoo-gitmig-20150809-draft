# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sg3_utils/sg3_utils-1.24.ebuild,v 1.5 2007/08/24 03:20:51 metalgod Exp $

inherit eutils

DESCRIPTION="apps for querying the sg SCSI interface (contains rescan_scsi_bus.sh)"
HOMEPAGE="http://www.torque.net/sg/"
SRC_URI="http://www.torque.net/sg/p/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc sparc x86"
IUSE=""
DEPEND="sys-devel/libtool"
RDEPEND=""
PDEPEND=">=sys-apps/rescan-scsi-bus-1.24"

src_unpack() {
	unpack ${P}.tgz
	cd "${S}"
	for i in Makefile utils/Makefile ; do
		sed -i \
			-e '/^CFLAGS/s:= -g -O2:+=:' \
			-e '/^LDFLAGS/s:=:+=:' \
			-e '/^PREFIX=/s:/local::' \
			-e 's:$(DESTDIR)/:$(DESTDIR):' \
			-e "/^LIBDIR=/s:/lib$:/$(get_libdir):" \
			-e '/^MANDIR=/s:)/man:)/share/man:' \
			-e '/ install /s: -s : :' \
			$i || die "sed of $i failed"
	done
}

src_compile() {
	emake || die "emake failed"
	emake -C utils || die "emake utils failed"
}

src_install() {
	dodoc examples/*.txt CHANGELOG COVERAGE CREDITS README*
	dohtml doc/*html
	make install DESTDIR="${D}" || die "make install failed"
	make -C utils install DESTDIR="${D}" || die "make install failed"
}
