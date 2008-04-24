# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/metalog/metalog-0.8-r1.ebuild,v 1.2 2008/04/24 04:37:35 ricmm Exp $

MY_P="${P/_/-}"
DESCRIPTION="A highly configurable replacement for syslogd/klogd"
HOMEPAGE="http://metalog.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/libpcre-3.4"
PROVIDE="virtual/logger"

S=${WORKDIR}/${MY_P}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS
	newdoc metalog.conf metalog.conf.sample

	insinto /etc
	doins "${FILESDIR}"/metalog.conf || die

	newinitd "${FILESDIR}"/metalog.initd metalog
	newconfd "${FILESDIR}"/metalog.confd metalog

	into /
	dosbin "${FILESDIR}"/consolelog.sh || die
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
