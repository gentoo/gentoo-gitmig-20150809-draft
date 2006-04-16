# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/apr-util/apr-util-0.9.6-r2.ebuild,v 1.16 2006/04/16 22:12:00 vericgar Exp $

inherit eutils

DESCRIPTION="Apache Portable Runtime Library"
HOMEPAGE="http://apr.apache.org/"
SRC_URI="mirror://apache/apr/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 s390 sh sparc x86"
IUSE="berkdb gdbm ldap"
RESTRICT="test"

DEPEND="dev-libs/expat
	~dev-libs/apr-0.9.6
	berkdb? ( sys-libs/db )
	gdbm? ( sys-libs/gdbm )
	ldap? ( =net-nds/openldap-2* )"

src_unpack() {
	unpack ${A} || die "unpack"

	cd ${S} || die

	epatch "${FILESDIR}/apr-util-0.9.x-161086-161087.patch" \
		|| die "patching failed"
}

src_compile() {
	local myconf=""
	if use ldap; then
		myconf="${myconf} --with-ldap"
	fi

	if use berkdb; then
		if has_version '=sys-libs/db-4.2*'; then
			myconf="${myconf} --with-dbm=db42
			--with-berkeley-db=/usr/include/db4.2:/usr/$(get_libdir)"
		elif has_version '=sys-libs/db-4*'; then
			myconf="${myconf} --with-dbm=db4
			--with-berkeley-db=/usr/include/db4:/usr/$(get_libdir)"
		elif has_version '=sys-libs/db-3*'; then
			myconf="${myconf} --with-dbm=db3
			--with-berkeley-db=/usr/include/db3:/usr/$(get_libdir)"
		elif has_version '=sys-libs/db-2'; then
			myconf="${myconf} --with-dbm=db2
			--with-berkely-db=/usr/include/db2:/usr/$(get_libdir)"
		fi
	fi

	econf \
		--datadir=/usr/share/apr-util-0 \
		--with-apr=/usr \
		--with-expat=/usr \
		$myconf || die

	emake || die
}

src_install() {
	make DESTDIR="${D}" installbuilddir=/usr/share/apr-util-0/build install || die

	#bogus values pointing at /var/tmp/portage
	sed -i -e 's:APU_SOURCE_DIR=.*:APU_SOURCE_DIR=:g' ${D}/usr/bin/apu-config
	sed -i -e 's:APU_BUILD_DIR=.*:APU_BUILD_DIR=/usr/share/apr-util-0/build:g' ${D}/usr/bin/apu-config

	dodoc CHANGES NOTICE

	# Will install as portage user when using userpriv. Fixing
	chown -R root:0 ${D}/usr/include/apr-0/
}
