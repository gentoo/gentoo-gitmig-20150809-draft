# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/sysstat-7.1.4.ebuild,v 1.1 2007/06/10 21:09:54 jer Exp $

inherit multilib

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://perso.wanadoo.fr/sebastien.godard/"
SRC_URI="http://perso.orange.fr/sebastien.godard/sysstat-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="nls"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

CONFIGVARS="PREFIX=\"${ROOT}usr\"
		SA_LIB_DIR=\"${ROOT}usr/$(get_libdir)/sa\"
		SA_DIR=\"${ROOT}var/log/sa\"
		CRON_OWNER=\"root\"
		DOC_DIR=\"${ROOT}usr/share/doc/${PF}\"
		MAN_DIR=\"${ROOT}usr/share/man/\""

src_compile() {
	if ! use nls ; then
		sed -i '19s:\(REQUIRE_NLS = \)[^\n]*:\1:' build/CONFIG || \
			die "sed CONFIG failed"
	fi
	econf || die "econf failed"
	emake LFLAGS="${LDFLAGS}" \
		${CONFIGVARS} \
		|| die "make failed"
}

src_install() {
	keepdir /var/log/sa

	emake \
		LFLAGS="${LDFLAGS}" \
		DESTDIR="${D}" \
		${CONFIGVARS} \
		install || die "make install failed"

	rm "${D}/usr/share/doc/${PF}/COPYING"
	ecompress "${D}/usr/share/doc/${PF}/"*[^mz]
	newdoc sysstat.crond.sample crontab.example
	newdoc sysstat.crond
	newinitd "${FILESDIR}"/sysstat.init.d sysstat
}
