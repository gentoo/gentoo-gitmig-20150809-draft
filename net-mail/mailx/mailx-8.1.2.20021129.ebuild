# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailx/mailx-8.1.2.20021129.ebuild,v 1.6 2003/09/05 02:52:24 msterret Exp $

MX_VER="8.1.1"
S=${WORKDIR}/mailx-${MX_VER}.orig

DESCRIPTION="The /bin/mail program, which is used to send mail via shell scripts."
SRC_URI="ftp://ftp.debian.org/debian/pool/main/m/mailx/mailx_${MX_VER}.orig.tar.gz"
HOMEPAGE="http://www.debian.org"

DEPEND=">=net-libs/liblockfile-1.03
	virtual/mta"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

src_unpack() {

	unpack ${A}
	cd ${S}
	bzcat ${FILESDIR}/20021129-cvs.diff.bz2 | patch -p1 \
		|| die "patch failed"

}

src_compile() {

	# Can't compile mailx with optimizations
	_CFLAGS=$(echo $CFLAGS|sed 's/-O.//g')

	make CFLAGS="$_CFLAGS" || die "make failed"

}

src_install() {

	dodir /bin /usr/share/man/man1 /etc /usr/lib

	insinto /bin
	insopts -m 755
	doins mail

	doman mail.1

	dosym mail /bin/Mail
	dosym mail /bin/mailx
	dosym mail.1 /usr/share/man/man1/Mail.1

	cd ${S}/misc
	insinto /usr/lib
	insopts -m 644
	doins mail.help mail.tildehelp
	insinto /etc
	insopts -m 644
	doins mail.rc

}
