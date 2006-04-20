# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sg3_utils/sg3_utils-1.20.ebuild,v 1.1 2006/04/20 20:30:43 robbat2 Exp $

inherit eutils

DESCRIPTION="apps for querying the sg SCSI interface (contains rescan_scsi_bus.sh)"
HOMEPAGE="http://www.torque.net/sg/"
SRC_URI="http://www.torque.net/sg/p/${P}.tgz
		http://www.garloff.de/kurt/linux/rescan-scsi-bus.sh"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${P}.tgz
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-llseek.patch
	for i in Makefile utils/Makefile ; do
		sed -i \
			-e "s:-g -O2:${CFLAGS}:g" \
			-e '/^PREFIX=/s:/local::' \
			-e 's:$(DESTDIR)/:$(DESTDIR):' \
			-e 's:/man:/share/man:' \
			-e "/^LIBDIR=/s:/lib:/$(get_libdir):" \
			$i || die "sed of $i failed"
	done
}

src_compile() {
	emake || die "emake failed"
	emake -C utils || die "emake utils failed"
}

src_install() {
	dobin "${DISTDIR}"/rescan-scsi-bus.sh || die "rescan-scsi-bus.sh failed"
	dodoc examples/*.txt CHANGELOG COVERAGE CREDITS README*
	dohtml doc/*html
	make install DESTDIR="${D}" || die "make install failed"
	make -C utils install DESTDIR="${D}" || die "make install failed"
}
