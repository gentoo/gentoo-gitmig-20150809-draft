# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/metalog/metalog-0.8_rc1.ebuild,v 1.1 2005/02/02 11:29:16 ka0ttic Exp $

inherit versionator

MY_P="${PN}-$(replace_version_separator 2 '-')"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="A highly configurable replacement for syslogd/klogd"
HOMEPAGE="http://metalog.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~arm ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/libpcre-3.4"
PROVIDE="virtual/logger"

src_unpack() {
	unpack ${A} ; cd ${S}
	sed -i "s:/metalog.conf:/metalog/metalog.conf:g" \
		src/metalog.h || die "sed metalog.h failed"
	sed -i "s:/etc/metalog.conf:/etc/metalog/metalog.conf:g" \
		man/metalog.8 || die "sed metalog.8 failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS TODO
	newdoc metalog.conf metalog.conf.sample

	insinto /etc/metalog ; doins ${FILESDIR}/metalog.conf

	newinitd ${FILESDIR}/metalog.rc6 metalog
	newconfd ${FILESDIR}/metalog.confd metalog

	exeinto /usr/sbin
	doexe ${FILESDIR}/consolelog.sh
}

pkg_postinst() {
	einfo "Buffering is now off by default.  Add -a to METALOG_OPTS"
	einfo "in /etc/conf.d/metalog to turn buffering back on."
}
