# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/qdbm/qdbm-1.8.30.ebuild,v 1.5 2005/08/03 21:21:05 kloeri Exp $

inherit java-pkg multilib

IUSE="debug java perl ruby zlib"

DESCRIPTION="Quick Database Manager"
HOMEPAGE="http://qdbm.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="alpha ~amd64 ppc ~ppc64 sparc x86"
SLOT="0"

DEPEND="java? ( virtual/jdk )
	perl? ( dev-lang/perl )
	ruby? ( virtual/ruby )
	zlib? ( sys-libs/zlib )"

src_compile() {

	econf \
		`use_enable debug` \
		`use_enable zlib` \
		--enable-pthread \
		--enable-iconv \
		|| die
	emake || die

	for u in java perl ruby; do
		if use $u; then
			cd $u
			econf || die
			make || die
			cd -
		fi
	done

}

src_install() {

	make DESTDIR=${D} install || die
	dodoc COPYING ChangeLog NEWS README THANKS

	for u in perl ruby; do
		if use $u; then
			cd $u
			make DESTDIR=${D} install || die
			cd -
		fi
	done

	if use java; then
		cd java
		make DESTDIR=${D} install || die
		java-pkg_dojar ${D}/usr/$(get_libdir)/*.jar
		rm ${D}/usr/$(get_libdir)/*.jar
		cd -
	fi

	rm ${D}/usr/bin/*test

}
