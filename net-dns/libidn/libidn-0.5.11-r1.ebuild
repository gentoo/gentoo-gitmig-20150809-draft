# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/libidn/libidn-0.5.11-r1.ebuild,v 1.2 2004/11/30 20:33:51 dragonheart Exp $

inherit java-pkg

DESCRIPTION="Internationalized Domain Names (IDN) implementation"
HOMEPAGE="http://www.gnu.org/software/libidn/"
SRC_URI="ftp://alpha.gnu.org/pub/gnu/libidn/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="java doc pic nls"

DEPEND="java? ( virtual/jdk )
	doc? ( dev-util/gtk-doc )"
RDEPEND="java? ( virtual/jre )"

check_java_config() {
	JDKHOME="`java-config --jdk-home`"
	if [[ -z "${JDKHOME}" || ! -d "${JDKHOME}" ]]; then
		NOJDKERROR="You need to use java-config to set your JVM to a JDK!"
		eerror "${NOJDKERROR}"
		die "${NOJDKERROR}"
	fi
}

src_compile() {
	if use java; then
		check_java_config
	fi

	econf \
		`use_enable nls` \
		`use_enable java` \
		`use_with pic` \
		${myconf} || die "Configure failed"

	emake || die "Make failed"
}

src_install() {
	make install DESTDIR="${D}" || die

	if use java; then
		java-pkg_dojar ${D}/usr/share/java/libidn-0.5.11.jar || die
		rm -rf ${D}/usr/share/java
		if use doc; then
			dohtml -r ${S}/doc/java
		fi
	fi

	dodoc AUTHORS ChangeLog FAQ NEWS README THANKS TODO
}
