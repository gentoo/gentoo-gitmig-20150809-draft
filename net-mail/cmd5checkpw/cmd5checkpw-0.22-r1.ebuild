# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/cmd5checkpw/cmd5checkpw-0.22-r1.ebuild,v 1.3 2004/01/29 03:25:23 avenj Exp $

DESCRIPTION="A checkpassword compatible authentication program that used CRAM-MD5 authentication mode."
HOMEPAGE="http://members.elysium.pl/brush/cmd5checkpw/"
SRC_URI="http://members.elysium.pl/brush/cmd5checkpw/dist/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc alpha ~amd64"
IUSE=""
DEPEND="virtual/glibc"
S=${WORKDIR}/${P}

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
