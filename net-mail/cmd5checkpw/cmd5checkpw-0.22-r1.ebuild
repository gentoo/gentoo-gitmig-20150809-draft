# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/cmd5checkpw/cmd5checkpw-0.22-r1.ebuild,v 1.8 2004/04/10 04:35:19 kumba Exp $

DESCRIPTION="A checkpassword compatible authentication program that used CRAM-MD5 authentication mode."
SRC_URI="http://members.elysium.pl/brush/cmd5checkpw/dist/${P}.tar.gz"
HOMEPAGE="http://members.elysium.pl/brush/cmd5checkpw/"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc alpha hppa amd64 ia64 mips"

DEPEND="virtual/glibc"

douser() {
	if  [ -z "`getent passwd cmd5checkpw`" ]; then
		enewuser cmd5checkpw 212 /bin/false /dev/null bin
	fi
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
	echo "${CC} ${CFLAGS}" > conf-cc
	echo "${CC} ${LDFLAGS}" > conf-ld
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
	chmod 400 /etc/poppasswd
	chown cmd5checkpw /etc/poppasswd
}
