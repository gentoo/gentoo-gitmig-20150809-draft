# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/metalog/metalog-0.8_rc1-r2.ebuild,v 1.15 2006/12/30 04:54:33 vapier Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
inherit versionator autotools

MY_P="${PN}-$(replace_version_separator 2 '-')"
DESCRIPTION="A highly configurable replacement for syslogd/klogd"
HOMEPAGE="http://metalog.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-libs/libpcre-3.4"
PROVIDE="virtual/logger"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc41.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog README NEWS TODO
	newdoc metalog.conf metalog.conf.sample

	insinto /etc
	doins "${FILESDIR}"/metalog.conf || die

	newinitd "${FILESDIR}"/metalog.initd metalog
	newconfd "${FILESDIR}"/metalog.confd metalog

	exeinto /usr/sbin
	dobin "${FILESDIR}"/consolelog.sh || die
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
