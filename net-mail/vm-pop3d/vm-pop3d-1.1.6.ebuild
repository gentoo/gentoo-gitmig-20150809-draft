# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/vm-pop3d/vm-pop3d-1.1.6.ebuild,v 1.3 2002/09/25 17:00:56 raker Exp $

S=${WORKDIR}/${P}

DESCRIPTION="vm-pop3d - vm-pop3d is a POP3 server"
SRC_URI="http://www.ibiblio.org/pub/Linux/system/mail/pop/${P}.tar.gz"
HOMEPAGE="http://www.reedmedia.net/software/virtualmail-pop3d/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/makefile.in.diff || die "patch failed"

}

src_compile() {

	local myconf

        use pam && myconf="${myconf} --enable-pam" \
		|| myconf="${myconf} --disable-pam "

	if [ -n "$DEBUG" ]; then
		myconf="${myconf} --enable-debug"
	else
		myconf="${myconf} --disable-debug"
	fi

	econf ${myconf} || die "configure failed"

	emake || die "make failed"

}

src_install () {

	einstall || die "make install failed"

	dodoc AUTHORS CHANGES COPYING FAQ INSTALL README TODO

        exeinto /etc/init.d
        newexe ${FILESDIR}/vm-pop3d.rc3 vm-pop3d
        insinto /etc/conf.d
        newins ${FILESDIR}/vm-pop3d.confd vm-pop3d

}
