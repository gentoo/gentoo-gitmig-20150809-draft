# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/aide/aide-0.10.ebuild,v 1.1 2004/03/29 15:09:32 zul Exp $

inherit eutils

DESCRIPTION="AIDE (Advanced Intrusion Detection Environment) is a replacement for Tripwire"
HOMEPAGE="http://aide.sourceforge.net/"
SRC_URI="mirror://sourceforge/aide/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="nls postgres zlib crypt"

DEPEND="app-arch/gzip
	sys-devel/bison
	sys-devel/flex
	app-crypt/mhash
	crypt? ( dev-libs/libgcrypt )
	postgres? ( dev-db/postgresql )
	zlib? ( sys-libs/zlib )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	# passing --without-psql or --with-psql causes postgres to be enabled ...
	# it's a broken configure.in file ... so lets just work around it
	local myconf=""
	use postgres && myconf="$myconf --with-psql"
	use crypt    && myconf="$myconf --with-gcrypt"

	econf \
		`use_with zlib` \
		`use_with nls locale` \
		--with-mhash \
		--sysconfdir=/etc/aide \
		--with-extra-lib=/usr/lib \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	einstall || die
	use nls || rm -rf ${D}/usr/lib/locale

	insinto /etc/aide
	doins doc/aide.conf

	dodoc AUTHORS NEWS README
	dohtml doc/manual.html
}
