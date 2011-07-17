# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/sysstat/sysstat-10.0.0.ebuild,v 1.7 2011/07/17 09:04:18 xarthisius Exp $

EAPI="2"

inherit eutils multilib

DESCRIPTION="System performance tools for Linux"
HOMEPAGE="http://pagesperso-orange.fr/sebastien.godard/"
SRC_URI="${HOMEPAGE}${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE="cron debug +doc isag nls lm_sensors"

SYSSTAT_LINGUAS="af cs da de es eu fi fr id it ja ky lv mt nb nl nn pl pt pt_BR
	ro ru sk sv uk vi zh_CN zh_TW"

for SYSSTAT_LINGUA in ${SYSSTAT_LINGUAS}; do
	IUSE="${IUSE} linguas_${SYSSTAT_LINGUA}"
done

RDEPEND="
	cron? ( sys-process/cronbase )
	isag? (
		dev-lang/tk
		dev-vcs/rcs
		sci-visualization/gnuplot
	)
	nls? ( virtual/libintl )
	lm_sensors? ( sys-apps/lm_sensors )
"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}/${P}-nls.patch"
	local lingua NLSDIR="${S}/nls"
	einfo "Keeping these locales: ${LINGUAS}."
	for lingua in ${SYSSTAT_LINGUAS}; do
		if ! use linguas_${lingua}; then
			rm -f "${NLSDIR}/${lingua}.po"
		fi
	done

	epatch "${FILESDIR}"/${P}-flags.patch
}

src_configure() {
	local myconf=""
	use doc || myconf="--disable-documentation"
	sa_lib_dir=/usr/$(get_libdir)/sa \
		econf ${myconf} \
			rcdir="Gentoo-does-not-use-rc.d" \
			$(use_enable cron install-cron) \
			$(use_enable debug debuginfo) \
			$(use_enable isag install-isag) \
			$(use_enable nls) \
			$(use_enable lm_sensors sensors) \
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

pkg_postinst() {
	ewarn "This version breaks the format of sar daily data files"
	ewarn "to enable the recording of average CPU clock frequency."
}
