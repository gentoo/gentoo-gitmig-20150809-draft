# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/mailx/mailx-8.1.1.11.ebuild,v 1.15 2003/09/05 02:52:24 msterret Exp $

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

	patch -p1 < ${FILESDIR}/${PF}.diff || die
	patch -p1 < ${FILESDIR}/${PF}-version.diff || die
	# It needs to install to /bin/mail (else conflicts with Postfix)
	# Also man pages go to /usr/share/man for FHS compliancy
	patch -p0 <${FILESDIR}/${PF}-Makefile.diff || die
}

src_compile() {

	# Can't compile mailx with optimizations
	_CFLAGS=$(echo $CFLAGS|sed 's/-O.//g')

	make CFLAGS="$_CFLAGS" || die

}

src_install() {

	dodir /bin /usr/share/man/man1 /etc /usr/lib
	make BINDIR=/bin DESTDIR=${D} install || die

	# Install the docs
	docinto debian
	dodoc debian/*

	# Some scripts require /bin/Mail
	dosym mail /bin/Mail
	dosym mail.1 /usr/share/man/man1/Mail.1
}
