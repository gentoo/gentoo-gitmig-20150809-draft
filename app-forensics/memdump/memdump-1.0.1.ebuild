# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/memdump/memdump-1.0.1.ebuild,v 1.4 2011/06/26 07:17:08 radhermit Exp $

EAPI=4

inherit toolchain-funcs

DESCRIPTION="Simple memory dumper for UNIX-Like systems"
HOMEPAGE="http://www.porcupine.org/forensics"
SRC_URI="http://www.porcupine.org/forensics/${PN}-1.01.tar.gz"
LICENSE="IBM"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
DEPEND=""
RDEPEND=""
IUSE=""

S=${WORKDIR}/${PN}-1.01

src_prepare() {
	sed -i -e 's:$(CFLAGS):\0 $(LDFLAGS):' Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" XFLAGS="${CFLAGS}" OPT= DEBUG=
}

src_test() {
	if [[ ${EUID} -ne 0 ]];
	then
		einfo "Cannot test with FEATURES=userpriv"
	elif [ -x /bin/wc ];
	then
		einfo "testing"
		if [ "`./memdump -s 344 | wc -c`" = "344" ];
		then
			einfo "passed test"
		else
			die "failed test"
		fi
	fi
}

src_install() {
	dosbin memdump
	dodoc README
	doman memdump.1
}
