# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libselinux/libselinux-1.18.ebuild,v 1.1 2004/11/14 18:45:50 pebenito Exp $

inherit eutils

IUSE=""

DESCRIPTION="SELinux userland library"
HOMEPAGE="http://www.nsa.gov/selinux"
SRC_URI="http://www.nsa.gov/selinux/archives/${P}.tgz"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"

DEPEND="sys-libs/glibc"

src_unpack() {
	unpack ${A}

	# add for compatibility, for now.  Otherwise the current sysvinit
	# patch fails to compile.
	sed -i -e 's/^\#endif//' ${S}/include/selinux/selinux.h
	echo '/* so older sysvinit patch can compile */' >> ${S}/include/selinux/selinux.h
	echo '#define SELINUXMNT "/selinux/"' >> ${S}/include/selinux/selinux.h
	echo '#define SELINUXPOLICY "/etc/security/selinux/policy"' >> ${S}/include/selinux/selinux.h
	echo '#endif' >> ${S}/include/selinux/selinux.h

	cd ${S}
	sed -i -e "s:-Wall:-Wall ${CFLAGS}:g" src/Makefile \
		|| die "src Makefile CFLAGS fix failed."
	sed -i -e "s:-Wall:-Wall ${CFLAGS}:g" utils/Makefile \
		|| die "utils Makefile CFLAGS fix failed."

	epatch ${FILESDIR}/selinuxconfig.c.diff
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
}
