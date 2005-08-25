# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/lingerd/lingerd-0.94.ebuild,v 1.10 2005/08/25 01:11:58 agriffis Exp $

inherit eutils

DESCRIPTION="Lingerd is a daemon designed to take over the job of properly closing network connections from an http server"
HOMEPAGE="http://www.iagora.com/about/software/lingerd/"
SRC_URI="http://images.iagora.com/media/software/lingerd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 ~mips ~ppc ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=sys-apps/sed-4"
RDEPEND=""

src_compile() {
	sed -i -e "s/\(CFLAGS  = -Wall \).*/\1 ${CFLAGS}/g" Makefile || die "Makefile fixing failed."
	emake || die "Emake failed."
}

src_install() {
	enewuser lingerd
	exeinto /usr/bin/ ; doexe lingerd || die "Installation failed."
	exeinto /etc/init.d ; newexe ${FILESDIR}/lingerd.rc lingerd
	dodoc ChangeLog LICENSE README TUNING INSTALL TODO extra/lingerd.rc
}

pkg_postinst() {
	install -m0770 -o lingerd -g apache -d ${ROOT}/var/run/lingerd/
}
