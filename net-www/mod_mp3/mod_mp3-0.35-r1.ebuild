# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_mp3/mod_mp3-0.35-r1.ebuild,v 1.3 2002/08/16 03:01:01 murphy Exp $

DESCRIPTION="Module for turning Apache into an MP3 or Ogg streaming server"
HOMEPAGE="http://media.tangent.org/"
KEYWORDS="x86 sparc sparc64"

S=${WORKDIR}/${P}
SRC_URI="http://software.tangent.org/download/${P}.tar.gz"

DEPEND="virtual/glibc >=net-www/apache-1.3.24 sys-devel/perl"
LICENSE="as-is"
SLOT="0"

src_compile() {
	./configure || die
	make clean
	make || die "compile problem"
}

src_install() {
	exeinto /usr/lib/apache-extramodules
	doexe src/mod_mp3.so

	dodoc CONTRIBUTORS MANIFEST TODO ChangeLog LICENSE README VERSION
	dodoc support/{faq.pod,mp3_with_mysql.conf,mysql_schema,pgsql_schema}
	dohtml faq.html

	insinto /etc/apache/conf/addon-modules
	doins ${FILESDIR}/mod_mp3.conf
}

pkg_postinst() {
	einfo
	einfo "Execute \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
	einfo "to have your apache.conf auto-updated for use with this module."
	einfo "You should then edit your /etc/conf.d/apache file to suit."
	einfo
}

pkg_config() {
	${ROOT}/usr/sbin/apacheaddmod \
		${ROOT}/etc/apache/conf/apache.conf \
		extramodules/mod_mp3.so mod_mp3.c mp3_module \
		define=MP3 addconf=conf/addon-modules/mod_mp3.conf
	:;
}
