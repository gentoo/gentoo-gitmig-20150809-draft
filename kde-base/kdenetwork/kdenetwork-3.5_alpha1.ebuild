# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.5_alpha1.ebuild,v 1.1 2005/08/24 23:15:33 greg_g Exp $

inherit kde-dist

DESCRIPTION="KDE network apps: kopete, kppp, kget..."

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="rdesktop sametime slp ssl wifi xmms"

DEPEND="~kde-base/kdebase-${PV}
	dev-libs/libxslt
	dev-libs/libxml2
	net-dns/libidn
	sametime? ( >=net-libs/meanwhile-0.4.2 )
	slp? ( net-libs/openslp )
	wifi? ( net-wireless/wireless-tools )
	xmms? ( media-sound/xmms )"

RDEPEND="${DEPEND}
	rdesktop? ( >=net-misc/rdesktop-1.4.1 )
	dev-lang/perl
	ssl? ( app-crypt/qca-tls
	       dev-perl/IO-Socket-SSL )"
# perl: for KSirc
# qca-tls: for Kopete jabber plugin.
# IO-Socket-SSL: for SSL support in KSirc.

DEPEND="${DEPEND}
	dev-util/pkgconfig"

src_compile() {
	local myconf="--with-libidn
	              $(use_enable sametime sametime-plugin)
	              $(use_enable slp) $(use_with wifi)
	              $(use_with xmms) --without-external-libgadu"

	kde_src_compile
}

src_install() {
	kde_src_install

	chmod u+s ${D}/${KDEDIR}/bin/reslisa

	# empty config file needed for lisa to work with default settings
	dodir /etc
	touch ${D}/etc/lisarc

	# lisa, reslisa initscripts
	sed -e "s:_KDEDIR_:${KDEDIR}:g" ${FILESDIR}/lisa > ${T}/lisa
	sed -e "s:_KDEDIR_:${KDEDIR}:g" ${FILESDIR}/reslisa > ${T}/reslisa
	exeinto /etc/init.d
	doexe ${T}/lisa ${T}/reslisa

	insinto /etc/conf.d
	newins ${FILESDIR}/lisa.conf lisa
	newins ${FILESDIR}/reslisa.conf reslisa
}
