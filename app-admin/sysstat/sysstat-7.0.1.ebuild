# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/sysstat-7.0.1.ebuild,v 1.1 2006/11/13 23:21:11 jokey Exp $

inherit multilib

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://perso.wanadoo.fr/sebastien.godard/"
SRC_URI="http://perso.orange.fr/sebastien.godard/sysstat-7.0.1.tar.gz"

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
		DOC_DIR=\"${ROOT}usr/share/doc/${PF}\""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:-O2:${CFLAGS}:" Makefile || die "sed Makefile failed"
}

src_compile() {
	if ! use nls ; then
		sed -i '19s:\(REQUIRE_NLS = \)[^\n]*:\1:' build/CONFIG || \
			die "sed CONFIG failed"
	fi

	emake LFLAGS=" " \
		${CONFIGVARS} \
		|| die "make failed"
}

src_install() {
	keepdir /var/log/sa
	newdoc "${FILESDIR}/crontab" crontab.example

	emake \
		DESTDIR="${D}" \
		${CONFIGVARS} \
		install || die "make install failed"

	rm "${D}/usr/share/doc/${PF}/COPYING"
	gzip "${D}/usr/share/doc/${PF}/"*[^mz]
}
