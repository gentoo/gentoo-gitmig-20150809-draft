# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/libidn/libidn-0.5.13.ebuild,v 1.1 2005/01/29 17:00:10 carlo Exp $

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

	if use amd64; then
		myconf="--with-pic"
	else
		myconf="`use_with pic`"
	fi
	econf \
		`use_enable nls` \
		`use_enable java` \
		${myconf} || die "Configure failed"

	emake || die "Make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die

	if use java; then
		java-pkg_dojar ${D}/usr/share/java/${P}.jar || die
		rm -rf ${D}/usr/share/java
		if use doc; then
			dohtml -r ${S}/doc/java
		fi
	fi

	dodoc AUTHORS ChangeLog FAQ NEWS README THANKS TODO
}
