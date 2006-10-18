# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/apr-util/apr-util-0.9.12.ebuild,v 1.17 2006/10/18 16:06:14 uberlord Exp $

inherit eutils flag-o-matic libtool db-use

DESCRIPTION="Apache Portable Runtime Library"
HOMEPAGE="http://apr.apache.org/"
SRC_URI="mirror://apache/apr/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="berkdb gdbm ldap"
RESTRICT="test"

DEPEND="dev-libs/expat
	~dev-libs/apr-${PV}
	berkdb? ( =sys-libs/db-4* )
	gdbm? ( sys-libs/gdbm )
	ldap? ( =net-nds/openldap-2* )"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die

	epatch ${FILESDIR}/apr-util-0.9.12-linking.patch
	elibtoolize || die "elibtoolize failed"
}


src_compile() {

	local myconf=""

	use ldap && myconf="${myconf} --with-ldap"
	myconf="${myconf} $(use_with gdbm)"

	if use berkdb; then
		dbver="$(db_findver sys-libs/db)" || die "Unable to find db version"
		dbver="$(db_ver_to_slot "$dbver")"
		dbver="${dbver/\./}"
		myconf="${myconf} --with-dbm=db${dbver}
		--with-berkeley-db=$(db_includedir):/usr/$(get_libdir)"
	else
		myconf="${myconf} --without-berkeley-db"
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

	# This file is only used on AIX systems, which gentoo is not,
	# and causes collisions between the SLOTs, so kill it
	rm ${D}/usr/$(get_libdir)/aprutil.exp

}
