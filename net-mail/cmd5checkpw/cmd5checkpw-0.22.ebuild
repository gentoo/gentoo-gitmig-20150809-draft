# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/cmd5checkpw/cmd5checkpw-0.22.ebuild,v 1.4 2003/04/15 21:37:10 agriffis Exp $

DESCRIPTION="A checkpassword compatible authentication program that used CRAM-MD5 authentication mode."
HOMEPAGE="http://members.elysium.pl/brush/cmd5checkpw/"
SRC_URI="http://members.elysium.pl/brush/cmd5checkpw/dist/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc alpha"
IUSE=""
DEPEND="virtual/glibc"
S=${WORKDIR}/${P}

pkg_preinst() {
        if ! grep -q ^cmd5checkpw: /etc/passwd
        then
                useradd -d /dev/null -g bin  -s /dev/null cmd5checkpw \
                        || die "problem adding user cmd5checkpw"
        fi
}

src_compile() {
	cp Makefile Makefile.orig
	sed \
		-e "s:-c -g -Wall -O3:${CFLAGS}:" \
		-e "s:cp cmd5checkpw /bin/:cp cmd5checkpw \${D}/bin/:" \
		-e "s:cp cmd5checkpw.8 /usr/man/man8/:cp cmd5checkpw.8 \${D}/usr/share/man/man8/:" \
		< Makefile.orig > Makefile
	cd ${S}
	echo "gcc ${CFLAGS}" > conf-cc
	make || die
}

src_install() {
	dodir /etc /bin /usr/share/man/man8
	cp ${FILESDIR}/poppasswd ${D}/etc
	make install
	chown cmd5checkpw ${D}/etc/poppasswd
	chmod 400 ${D}/etc/poppasswd
	chown cmd5checkpw ${D}/bin/cmd5checkpw
	chmod a+s ${D}/bin/cmd5checkpw
}
