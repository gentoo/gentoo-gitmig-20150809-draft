# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/metalog/metalog-0.8_rc1-r1.ebuild,v 1.1 2005/03/15 03:36:40 vapier Exp $

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

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS TODO
	newdoc metalog.conf metalog.conf.sample

	insinto /etc
	doins "${FILESDIR}"/metalog.conf

	newinitd "${FILESDIR}"/metalog.rc7 metalog
	newconfd "${FILESDIR}"/metalog.confd metalog

	exeinto /usr/sbin
	doexe "${FILESDIR}"/consolelog.sh
}

pkg_preinst() {
	if [[ -d "${ROOT}"/etc/metalog ]] && [[ ! -e "${ROOT}"/etc/metalog.conf ]] ; then
		mv -f "${ROOT}"/etc/metalog/metalog.conf "${ROOT}"/etc/metalog.conf
		rmdir "${ROOT}"/etc/metalog
	fi
}

pkg_postinst() {
	ewarn "The default metalog.conf file has been moved"
	ewarn "from /etc/metalog/metalog.conf to just"
	ewarn "/etc/metalog.conf.  If you had a standard"
	ewarn "setup, the file has been moved for you."
}
