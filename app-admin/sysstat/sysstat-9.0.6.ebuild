# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/sysstat-9.0.6.ebuild,v 1.7 2009/12/19 01:48:09 rich0 Exp $

EAPI="2"

inherit eutils multilib

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://perso.wanadoo.fr/sebastien.godard/"
SRC_URI="http://perso.orange.fr/sebastien.godard/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="cron +doc isag nls"

RDEPEND="
	cron? ( sys-process/cronbase )
	isag? (
		app-text/rcs
		dev-lang/tk
		sci-visualization/gnuplot
	)
	nls? ( virtual/libintl )
"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_configure() {
	local myconf=""
	use doc || myconf="--disable-documentation"
	sa_lib_dir=/usr/$(get_libdir)/sa \
		econf ${myconf} \
			rcdir="Gentoo-does-not-use-rc.d" \
			$(use_enable cron install-cron) \
			$(use_enable isag install-isag) \
			$(use_enable nls) \
			conf_dir=/etc || die "econf failed"
}

src_compile() {
	emake LFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	keepdir /var/log/sa

	use cron && dodir /etc/cron.{daily,hourly}

	emake \
		DESTDIR="${D}" \
		DOC_DIR=/usr/share/doc/${PF} \
		install || die "make install failed"

	dodoc contrib/sargraph/sargraph

	newinitd "${FILESDIR}"/sysstat.init.d sysstat

	use doc && rm -f "${D}"usr/share/doc/${PF}/COPYING
}
