# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sus/sus-2.0.1.ebuild,v 1.1 2003/06/28 02:51:18 kumba Exp $

DESCRIPTION="allows certain users to run commands as root or other users"
SRC_URI="http://pdg.uow.edu.au/sus/${P}.tar.Z"
HOMEPAGE="http://pdg.uow.edu.au/sus/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~mips"
IUSE="pam"

DEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.73-r1 )"

src_compile() {
	local myconf
	local lflags
	myconf="-DDEBUG"
	use pam > /dev/null 2>&1 && myconf="${myconf} -DUSE_PAM" && lflags="-lpam"
	myconf="${myconf} -DPROMISCUOUS -DUSE_SHADOW \
		-DSUSERS=\\\"/etc/susers.cpp\\\""
	make \
		CC=${CC} \
		CFLAGS="${CFLAGS} ${myconf}" \
		LFLAGS="${lflags}" \
		sus || die
}

src_install() {
	ln -s man/sus.1 sus.8
	dobin sus
	doman sus.8
	dodoc COPYING INSTALL README susers.sample
	dodir /var/run/sus
	insinto /etc
	newins ${FILESDIR}/susers.cpp susers.cpp
	fperms 4755 /usr/bin/sus
	fperms 700 /var/run/sus
	insinto /etc
	doins ${FILESDIR}/susers.cpp
}

pkg_postinst() {
	einfo ""
	einfo "A default configuration file has been installed as"
	einfo "/etc/susers.cpp.  It is best to read over it and"
	einfo "make any changes as necessary."
	einfo ""
}
