# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/skey/skey-1.1.5-r2.ebuild,v 1.3 2004/09/15 00:29:22 pvdabeel Exp $

inherit flag-o-matic ccc eutils

DESCRIPTION="Linux Port of OpenBSD Single-key Password System"
HOMEPAGE="http://www.sparc.spb.su/solaris/skey/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="BSD X11"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~s390 ppc64"
IUSE=""

DEPEND="sys-libs/cracklib
	sys-apps/shadow
	dev-lang/perl
	virtual/libc"
# XXX: skeyaudit requires mailx.

src_unpack() {
	unpack ${A} ; cd ${S}

	# porting some updates to this skey implementation from the
	# NetBSD project, some other updates and fixes, and the addition
	# of some new features like shadow password and cracklib support.
	# 	(05 Nov 2003) -taviso@gentoo.org
	epatch ${FILESDIR}/skey-1.1.5-gentoo.diff.gz

	# glibc 2.2.x does not define LOGIN_NAME_MAX #33315
	# 	(12 Nov 2003) -taviso@gentoo.org
	epatch ${FILESDIR}/skey-login_name_max.diff

	epatch ${FILESDIR}/${P}-fPIC.patch
}

src_compile() {
	# skeyprune wont honour @sysconfdir@
	sed -i 's#/etc/skeykeys#/etc/skey/skeykeys#g' skeyprune.pl skeyprune.8

	econf --sysconfdir=/etc/skey || die
	emake || die
}

src_install() {
	doman skey.1 skeyaudit.1 skeyinfo.1 skeyinit.1 skeyprune.8
	dobin skey skeyinit skeyinfo || die
	newbin skeyprune.pl skeyprune
	newbin skeyaudit.sh skeyaudit
	dolib.a libskey.a
	dolib.so libskey.so.1.1.5 libskey.so.1.1 libskey.so.1 libskey.so

	insinto /usr/include
	doins skey.h

	insinto /etc/skey
	newins /dev/null skeykeys

	# only root needs to have access to these files.
	fperms g-rx,o-rx /etc/skey/skeykeys /etc/skey

	# skeyinit and skeyinfo must be suid root so users
	# can generate their passwords.
	fperms u+s,o-r,g-r /usr/bin/skeyinit /usr/bin/skeyinfo

	dodoc README CHANGES md4.copyright md5.copyright

	prepallman
}

pkg_postinst() {
	einfo "For an instroduction into using s/key authentication, take"
	einfo "a look at the EXAMPLES section from the skey(1) manpage."
}
