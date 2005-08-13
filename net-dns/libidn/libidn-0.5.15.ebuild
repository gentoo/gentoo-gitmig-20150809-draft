# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/libidn/libidn-0.5.15.ebuild,v 1.10 2005/08/13 23:22:52 hansmi Exp $

inherit java-pkg

DESCRIPTION="Internationalized Domain Names (IDN) implementation"
HOMEPAGE="http://www.gnu.org/software/libidn/"
SRC_URI="ftp://alpha.gnu.org/pub/gnu/libidn/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sparc x86"
IUSE="java doc nls emacs"

DEPEND="java? ( >=virtual/jdk-1.4 )"
RDEPEND="java? ( >=virtual/jre-1.4 )"

src_compile() {
	local jdkhome

	if use java; then
		jdkhome=$(java-config --jdk-home)
		if [[ -z ${jdkhome} || ! -d ${jdkhome} ]]; then
			die "You need to use java-config to set your JVM to a JDK!"
		fi
	fi

	econf \
		$(use_enable nls) \
		$(use_enable java) \
		|| die

	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog FAQ NEWS README THANKS TODO

	use emacs || rm -r ${D}/usr/share/emacs

	if use doc; then
		dohtml -r doc/reference/html/*
	fi

	if use java; then
		java-pkg_dojar ${D}/usr/share/java/${P}.jar || die
		rm -rf ${D}/usr/share/java

		if use doc; then
			dohtml -r doc/java
		fi
	fi
}
