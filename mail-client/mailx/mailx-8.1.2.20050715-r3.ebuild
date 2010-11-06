# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mailx/mailx-8.1.2.20050715-r3.ebuild,v 1.4 2010/11/06 13:35:43 maekke Exp $

inherit eutils flag-o-matic toolchain-funcs

MX_MAJ_VER=${PV%.*}
MX_MIN_VER=${PV##*.}
MY_PV=${MX_MAJ_VER}-0.${MX_MIN_VER}cvs
S=${WORKDIR}/${PN}-${MY_PV}.orig/
debian_patch=${PN}_${MY_PV}-1.diff.gz

DESCRIPTION="The /bin/mail program, which is used to send mail via shell scripts"
HOMEPAGE="http://www.debian.org/"
SRC_URI="mirror://gentoo/mailx_${MY_PV}.orig.tar.gz
	mirror://gentoo/${debian_patch}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ~ia64 ~mips ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=">=net-libs/liblockfile-1.03
	virtual/mta
	!mail-client/mailutils
	mail-client/mailx-support
	!virtual/mailx"
PROVIDE="virtual/mailx"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${DISTDIR}/${debian_patch}"
	epatch "${FILESDIR}/${P}-nostrip.patch"
	sed -i -e "s: -O2: \$(EXTRAFLAGS):g" Makefile
	epatch "${FILESDIR}/${P}-offsetof.patch"
}

src_compile() {
	emake CC=$(tc-getCC) EXTRAFLAGS="${CFLAGS}" || die
}

src_install() {
	dodir /bin /usr/share/man/man1 /etc /usr/lib

	insinto /bin
	insopts -m 755
	doins mail || die

	doman mail.1

	dosym mail /bin/Mail
	dosym mail /bin/mailx
	dosym mail.1 /usr/share/man/man1/Mail.1

	cd "${S}"/misc
	insinto /usr/share/${PN}/
	insopts -m 644
	doins mail.help mail.tildehelp || die
	insinto /etc
	insopts -m 644
	doins mail.rc || die
}
