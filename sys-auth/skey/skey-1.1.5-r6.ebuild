# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/skey/skey-1.1.5-r6.ebuild,v 1.1 2008/05/11 12:36:09 ulm Exp $

inherit flag-o-matic ccc eutils toolchain-funcs

DESCRIPTION="Linux Port of OpenBSD Single-key Password System"
HOMEPAGE="http://www.sparc.spb.su/solaris/skey/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
		mirror://gentoo/skey-1.1.5-gentoo.diff.gz"

LICENSE="BSD MIT RSA-MD4 RSA-MD5 BEER-WARE"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	sys-libs/cracklib"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# porting some updates to this skey implementation from the
	# NetBSD project, some other updates and fixes, and the addition
	# of some new features like shadow password and cracklib support.
	# 	(05 Nov 2003) -taviso@gentoo.org
	epatch "${WORKDIR}"/skey-1.1.5-gentoo.diff

	# glibc 2.2.x does not define LOGIN_NAME_MAX #33315
	# 	(12 Nov 2003) -taviso@gentoo.org
	epatch "${FILESDIR}"/skey-login_name_max.diff

	epatch "${FILESDIR}"/${P}-fPIC.patch
	epatch "${FILESDIR}"/${P}-bind-now.patch

	# allow invokation as otp-foo. #71015
	# 	(03 Mar 2005) -taviso.
	epatch "${FILESDIR}"/${P}-otp.diff

	# set the default hash function to md5, #63995
	# 	(14 Sep 2004) -taviso
	append-flags -DSKEY_HASH_DEFAULT=1

	# skeyprune wont honour @sysconfdir@
	sed -i \
		-e 's:/etc/skeykeys:/etc/skey/skeykeys:g' \
		skeyprune.pl skeyprune.8 || die

	# skeyprune uses a case sensitive regex to check for zeroed entries
	sed -i \
		-e 's:\(if ( ! /.*/\):\1i:g' \
		skeyprune.pl || die

	# skeyinit(1) describes md4 as the default hash algorithm, which
	# is no longer the case. #64971
	sed -i \
		's#\(md4\) \((the default)\), \(md5\) or \(sha1.\)#\1, \3 \2 or \4#g' \
		skeyinit.1
}

src_compile() {
	econf --sysconfdir=/etc/skey || die
	emake || die
}

src_install() {
	doman skey.1 skeyaudit.1 skeyinfo.1 skeyinit.1 skeyprune.8
	dobin skey skeyinit skeyinfo || die

	dosym skey /usr/bin/otp-md4
	dosym skey /usr/bin/otp-sha1
	dosym skey /usr/bin/otp-md5

	newsbin skeyprune.pl skeyprune
	newbin skeyaudit.sh skeyaudit

	dolib.a libskey.a

	into /
	dolib.so libskey.so.1.1.5 libskey.so.1.1 libskey.so.1 libskey.so || die
	gen_usr_ldscript libskey.so

	insinto /usr/include
	doins skey.h

	dodir /etc/skey

	# only root needs to have access to these files.
	fperms g-rx,o-rx /etc/skey

	# skeyinit and skeyinfo must be suid root so users
	# can generate their passwords.
	fperms u+s,og-r /usr/bin/skeyinit /usr/bin/skeyinfo

	dodoc README CHANGES
}

pkg_postinst() {
	# do not include /etc/skey/skeykeys in the package, as quickpkg
	# may package sensitive information.
	# This also fixes the etc-update issue with #64974.

	# skeyinit will not function if this file is not present.
	touch /etc/skey/skeykeys

	# these permissions are applied by the skey system if missing.
	chmod 0600 /etc/skey/skeykeys

	elog "For an introduction into using s/key authentication, take"
	elog "a look at the EXAMPLES section from the skey(1) manpage."
}
