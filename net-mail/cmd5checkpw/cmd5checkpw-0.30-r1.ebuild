# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/cmd5checkpw/cmd5checkpw-0.30-r1.ebuild,v 1.1 2008/04/06 17:11:21 hollow Exp $

inherit eutils fixheadtails qmail

MY_VER="030"

DESCRIPTION="A checkpassword compatible authentication program that used CRAM-MD5 authentication mode."
SRC_URI="http://www.fehcom.de/qmail/auth/${PN}-${MY_VER}_tgz.bin"
HOMEPAGE="http://www.fehcom.de/qmail/smtpauth.html"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

pkg_setup() {
	enewuser cmd5checkpw 212 -1 /dev/null bin
	ewarn
	ewarn "this version is in NO WAY COMPATIBLE with cmd5checkpw-0.2x"
	ewarn "it actually receives the authentication credentials"
	ewarn "in a different order then the old implementation"
	ewarn "see bug #100693 for details"
	ewarn "this version IS needed by >=qmail-1.03-r16"
	ewarn
}

src_unpack() {
	mv "${DISTDIR}"/${PN}-${MY_VER}{_tgz.bin,.tar.gz}
	unpack ${PN}-${MY_VER}.tar.gz
	cd "${S}"

	epatch "${FILESDIR}"/euid_${MY_VER}.diff
	epatch "${FILESDIR}"/reloc.diff

	sed \
		-e "s:-c -g -Wall -O3:${CFLAGS}:" \
		-e "s:cp cmd5checkpw /bin/:cp cmd5checkpw \${D}/bin/:" \
		-e "s:cp cmd5checkpw.8 /usr/man/man8/:cp cmd5checkpw.8 \${D}/usr/share/man/man8/:" \
		-i Makefile

	ht_fix_file Makefile

	qmail_set_cc
}

src_compile() {
	emake || die
}

src_install() {
	insinto /etc
	doins "${FILESDIR}"/poppasswd

	exeinto /bin
	doexe cmd5checkpw

	doman cmd5checkpw.8

	fowners cmd5checkpw /etc/poppasswd /bin/cmd5checkpw
	fperms 400 /etc/poppasswd
	fperms u+s /bin/cmd5checkpw
}

pkg_postinst() {
	chmod 400 "${ROOT}"/etc/poppasswd
	chown cmd5checkpw "${ROOT}"/etc/poppasswd
}
