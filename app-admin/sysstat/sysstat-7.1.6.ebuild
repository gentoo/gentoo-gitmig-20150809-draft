# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/sysstat-7.1.6.ebuild,v 1.2 2007/08/28 15:10:36 jer Exp $

inherit eutils multilib

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://perso.wanadoo.fr/sebastien.godard/"
SRC_URI="http://perso.orange.fr/sebastien.godard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="nls"

RDEPEND="nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch ${FILESDIR}/${PN}-7.1.4-strip.patch || die "${P}-strip.patch failed"
}

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake LFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	keepdir /var/log/sa

	emake DESTDIR=${D} DOC_DIR=/usr/share/doc/${PF} \
		install || die "make install failed"

	newdoc sysstat.crond.sample crontab.example
	newinitd "${FILESDIR}"/sysstat.init.d sysstat
}
