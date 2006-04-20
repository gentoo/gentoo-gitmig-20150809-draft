# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/hyperestraier/hyperestraier-1.1.5.ebuild,v 1.2 2006/04/20 14:58:06 hattya Exp $

inherit java-pkg

IUSE="bzip2 debug java ruby"

DESCRIPTION="a full-text search system for communities"
HOMEPAGE="http://hyperestraier.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~ppc x86"
SLOT="0"

DEPEND=">=dev-db/qdbm-1.8.46
	sys-libs/zlib
	bzip2? ( app-arch/bzip2 )"

src_compile() {

	econf \
		`use_enable bzip2 bzip` \
		`use_enable debug` \
		|| die
	emake || die

	local binding

	for binding in java ruby; do
		if ! use ${binding}; then
			continue
		fi

		local dir

		for dir in ${binding}native ${binding}pure; do
			cd ${dir}
			econf || die
			emake || die
			cd ..
		done
	done

}

src_test() {

	make -s check || die

	local binding

	for binding in java ruby; do
		if ! use ${binding}; then
			continue
		fi

		local dir

		for dir in ${binding}native; do
			cd ${dir}
			make -s check || die
			cd ..
		done
	done

}

src_install() {

	make DESTDIR=${D} MYDATADIR=/usr/share/doc/${P} install || die
	dodoc COPYING README* ChangeLog THANKS

	if use java; then
		cd javanative
		make DESTDIR=${D} install || die
		rm -f ${D}/usr/lib/*.jar
		cd ..
		java-pkg_dojar java*/*.jar || die

	else
		rm -rf ${D}/usr/share/doc/${P}/doc/java*

	fi

	if use ruby; then
		for dir in rubynative rubypure; do
			cd ${dir}
			make DESTDIR=${D} install || die
			cd ..
		done

	else
		rm -rf ${D}/usr/share/doc/${P}/doc/ruby*

	fi

	rm -f ${D}/usr/bin/*test

}
