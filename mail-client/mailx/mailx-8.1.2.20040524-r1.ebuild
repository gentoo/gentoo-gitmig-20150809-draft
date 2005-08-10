# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mailx/mailx-8.1.2.20040524-r1.ebuild,v 1.13 2005/08/10 11:26:52 ka0ttic Exp $

inherit ccc eutils flag-o-matic

IUSE=""
MX_VER="8.1.2"
S=${WORKDIR}/${PN}-${MX_VER}

DESCRIPTION="The /bin/mail program, which is used to send mail via shell scripts."
SRC_URI="mirror://gentoo/mailx_${MX_VER}.orig.tar.gz
	mirror://gentoo/${PN}-20040524-cvs.diff.bz2"
HOMEPAGE="http://www.debian.org"

DEPEND=">=net-libs/liblockfile-1.03
	virtual/mta
	!mail-client/mailutils
	mail-client/mailx-support
	!virtual/mailx"
PROVIDE="virtual/mailx"

SLOT="0"
LICENSE="BSD"
KEYWORDS="alpha amd64 ~hppa ia64 mips ppc ppc64 sparc x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/${PN}-20040524-cvs.diff.bz2 || die "epatch failed"
	sed -i -e "s: -O2: \$(EXTRAFLAGS):g" Makefile
}

src_compile() {
	is-ccc && replace-cc-hardcode
	make EXTRAFLAGS="${CFLAGS}" || die
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
	insinto /usr/share/${PN}/
	insopts -m 644
	doins mail.help mail.tildehelp
	insinto /etc
	insopts -m 644
	doins mail.rc
}
