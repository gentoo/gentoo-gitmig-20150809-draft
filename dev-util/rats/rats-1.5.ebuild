# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/rats/rats-1.5.ebuild,v 1.1 2002/08/28 02:57:34 gaarde Exp $

# Author:  Paul Belt <gaarde@gentoo.org>

DESCRIPTION="RATS, the Rough Auditing Tool for Security, is a security auditing utility for C, C++, Perl, and Python code. RATS scans source code, finding potentially dangerous function calls. It provides a reasonable starting point for performing manual security audits."
HOMEPAGE="http://www.securesoftware.com/rats.php"
SRC_URI="http://www.securesoftware.com/rats/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
RDEPEND=""
DEPEND="${RDEPEND}"

src_compile() {
	econf --mandir=${D}/usr/share/man/man1 || die
	emake || die
}

src_install () {
	einstall || die
}
