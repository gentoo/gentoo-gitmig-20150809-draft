# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/metalog/metalog-0.7-r1.ebuild,v 1.14 2004/09/21 22:30:50 vapier Exp $

DESCRIPTION="A highly configurable replacement for syslogd/klogd"
HOMEPAGE="http://metalog.sourceforge.net/"
SRC_URI="mirror://sourceforge/metalog/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha arm amd64 hppa ia64 mips ppc s390 sparc x86"
IUSE=""

DEPEND=">=dev-libs/libpcre-3.4"
PROVIDE="virtual/logger"

src_unpack() {
	unpack ${A} ; cd ${S}
	cd ${S}/src
	sed -i -e "s:/metalog.conf:/metalog/metalog.conf:g" \
		metalog.h
	cd ${S}/man
	sed -i -e "s:/etc/metalog.conf:/etc/metalog/metalog.conf:g" \
		metalog.8
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog README
	newdoc metalog.conf metalog.conf.sample

	insinto /etc/metalog ; doins ${FILESDIR}/metalog.conf
	exeinto /etc/init.d ; newexe ${FILESDIR}/metalog.rc6 metalog
	insinto /etc/conf.d ; newins ${FILESDIR}/metalog.confd metalog

	exeinto /usr/sbin
	doexe ${FILESDIR}/consolelog.sh
}

pkg_postinst() {
	einfo "Buffering is now off by default in metalog 0.7.  Add -a to"
	einfo "METALOG_OPTS in /etc/conf.d/metalog to turn buffering back on."
}
