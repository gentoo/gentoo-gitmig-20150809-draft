# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sus/sus-2.0.2-r1.ebuild,v 1.3 2005/05/30 17:47:59 swegener Exp $

inherit eutils toolchain-funcs

DESCRIPTION="allows certain users to run commands as root or other users"
HOMEPAGE="http://pdg.uow.edu.au/sus/"
SRC_URI="http://pdg.uow.edu.au/sus/${P}.tar.Z"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc mips"
IUSE="pam"

DEPEND="virtual/libc
	pam? ( >=sys-libs/pam-0.73-r1 )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fixes a local root vulnerability (Bug #63927)
	epatch ${FILESDIR}/${P}-syslog-vuln-fix.patch
}

src_compile() {
	local myconf
	local lflags
	myconf="-DDEBUG"
	use pam && myconf="${myconf} -DUSE_PAM" && lflags="-lpam"
	myconf="${myconf} -DPROMISCUOUS -DUSE_SHADOW \
		-DSUSERS=\\\"/etc/susers.cpp\\\""
	make \
		CC=$(tc-getCC) \
		CFLAGS="${CFLAGS} ${myconf}" \
		LFLAGS="${lflags}" \
		sus || die
}

src_install() {
	dobin sus || die
	newman man/sus.1 sus.8
	dodoc INSTALL README susers.sample
	dodir /var/run/sus
	insinto /etc
	newins ${FILESDIR}/susers.cpp susers.cpp
	fperms 4755 /usr/bin/sus
	fperms 700 /var/run/sus
	insinto /etc
	doins ${FILESDIR}/susers.cpp
}

pkg_postinst() {
	einfo "A default configuration file has been installed as"
	einfo "/etc/susers.cpp.  It is best to read over it and"
	einfo "make any changes as necessary."
}
