# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/libidn/libidn-0.6.1.ebuild,v 1.4 2006/04/01 00:00:50 flameeyes Exp $

inherit java-pkg mono libtool

DESCRIPTION="Internationalized Domain Names (IDN) implementation"
HOMEPAGE="http://www.gnu.org/software/libidn/"
SRC_URI="ftp://alpha.gnu.org/pub/gnu/libidn/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="java doc emacs mono nls"

DEPEND="java? ( >=virtual/jdk-1.4
		mono? ( >=dev-lang/mono-0.95 )
				dev-java/gjdoc )"
RDEPEND="java? ( >=virtual/jre-1.4 )
		mono? ( >=dev-lang/mono-0.95 )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	elibtoolize
}

src_compile() {
	local jdkhome=""
	local myconf=" --disable-csharp"

	if use java; then
		jdkhome=$(java-config --jdk-home)
		if [[ -z ${jdkhome} || ! -d ${jdkhome} ]]; then
			die "You need to use java-config to set your JVM to a JDK!"
		fi
	fi

	use mono && myconf="--enable-csharp=mono"

	econf \
		$(use_enable nls) \
		$(use_enable java) \
		${myconf} \
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
