# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/cmd5checkpw/cmd5checkpw-0.22-r1.ebuild,v 1.17 2005/08/23 13:40:42 ticho Exp $

inherit eutils toolchain-funcs

DESCRIPTION="A checkpassword compatible authentication program that used CRAM-MD5 authentication mode."
SRC_URI="http://members.elysium.pl/brush/cmd5checkpw/dist/${P}.tar.gz"
HOMEPAGE="http://members.elysium.pl/brush/cmd5checkpw/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64"
IUSE=""

DEPEND="virtual/libc"

douser() {
	enewuser cmd5checkpw 212 -1 /dev/null bin
}

pkg_preinst() {
	douser
}

pkg_setup() {
	douser
}

src_compile() {
	cp Makefile Makefile.orig
	sed \
		-e "s:-c -g -Wall -O3:${CFLAGS}:" \
		-e "s:cp cmd5checkpw /bin/:cp cmd5checkpw \${D}/bin/:" \
		-e "s:cp cmd5checkpw.8 /usr/man/man8/:cp cmd5checkpw.8 \${D}/usr/share/man/man8/:" \
		< Makefile.orig > Makefile
	cd ${S}
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld
	make || die
}

src_install() {
	dodir /etc /bin /usr/share/man/man8
	insinto /etc
	doins ${FILESDIR}/poppasswd
	make install
	fowners cmd5checkpw /etc/poppasswd /bin/cmd5checkpw
	fperms 400 /etc/poppasswd
	fperms u+s /bin/cmd5checkpw
}

pkg_postinst() {
	chmod 400 ${ROOT}/etc/poppasswd
	chown cmd5checkpw ${ROOT}/etc/poppasswd
}
