# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/supervise-scripts/supervise-scripts-3.5.ebuild,v 1.1 2003/08/28 20:12:08 robbat2 Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Starting and stopping daemontools managed services."
SRC_URI="http://untroubled.org/supervise-scripts/${P}.tar.gz"
HOMEPAGE="http://untroubled.org/supervise-scripts/"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~arm ~hppa ~alpha ~mips "
SLOT="0"
LICENSE="GPL-2"
RDEPEND=">=sys-apps/daemontools-0.70"
DEPEND=">=sys-apps/daemontools-0.70
		 dev-libs/bglibs
		 sys-devel/gcc-config"

src_compile() {
	echo '/usr/lib/bglibs/lib' > conf-bglibs
	echo '/usr/lib/bglibs/include' > conf-bgincs
	echo "${CC} ${CFLAGS}" >conf-cc
	echo "${CC} ${LDFLAGS}" >conf-ld
	emake || die
}

src_install() {
	into /usr
	exeinto /usr/bin
	doexe svc-add svc-isdown svc-isup svc-remove \
				svc-start svc-status svc-stop svc-restart \
				svc-waitdown svc-waitup svscan-add-to-inittab \
				svscan-add-to-inittab svscan-start svscan-stopall
	dodoc ANNOUNCEMENT COPYING ChangeLog NEWS README TODO VERSION
	doman *.[0-9]
}
