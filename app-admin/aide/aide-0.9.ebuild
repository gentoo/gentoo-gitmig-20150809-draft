# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/aide/aide-0.9.ebuild,v 1.9 2003/05/13 20:55:21 taviso Exp $

inherit eutils

DESCRIPTION="AIDE (Advanced Intrusion Detection Environment) is a replacement for Tripwire"
HOMEPAGE="http://www.cs.tut.fi/~rammer/aide.html"
SRC_URI="http://www.cs.tut.fi/~rammer/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc sparc ~alpha"
IUSE="nls postgres zlib crypt"

DEPEND="sys-apps/gzip
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
	use postgres && myconf="--with-psql"

	econf \
		`use_with zlib` \
		`use_with nls locale` \
		`use_with crypt gcrypt` \
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
