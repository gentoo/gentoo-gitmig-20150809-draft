# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailx/mailx-8.1.2.20021129-r1.ebuild,v 1.4 2003/05/27 16:08:11 taviso Exp $

inherit ccc 

MX_VER="8.1.1"
S=${WORKDIR}/mailx-${MX_VER}.orig

DESCRIPTION="The /bin/mail program, which is used to send mail via shell scripts."
SRC_URI="ftp://ftp.debian.org/debian/pool/main/m/mailx/mailx_${MX_VER}.orig.tar.gz
	mirror://gentoo/multifix.diff.gz
	mirror://gentoo/20021129-cvs.diff.bz2"
HOMEPAGE="http://www.debian.org"

DEPEND=">=net-libs/liblockfile-1.03 
        virtual/mta
	!net-mail/mailutils"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/20021129-cvs.diff.bz2 || die "patch failed"
	epatch ${DISTDIR}/multifix.diff.gz || die "patch failed"
}

src_compile() {
	
	is-ccc && replace-cc-hardcode 

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
