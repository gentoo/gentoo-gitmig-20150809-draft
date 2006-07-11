# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.4.3.ebuild,v 1.11 2006/07/11 18:46:13 flameeyes Exp $

inherit kde-dist eutils

DESCRIPTION="KDE network apps: kopete, kppp, kget..."

KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="rdesktop slp ssl wifi xmms"

DEPEND="~kde-base/kdebase-${PV}
	dev-libs/libxslt
	dev-libs/libxml2
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

src_unpack() {
	kde_src_unpack

	# Disable meanwhile support in kopete. See bug 96778.
	epatch "$FILESDIR/disable-meanwhile.diff"

	# Configure patch. Applied for 3.5.
	epatch "${FILESDIR}/kdenetwork-3.4-configure.patch"

	# For the configure patch.
	make -f admin/Makefile.common || die
}

src_compile() {
	local myconf="$(use_enable slp) $(use_with wifi)
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

pkg_postinst() {
	elog "Since 11 July 2006 the version of Kopete here built cannot connect to ICQ service"
	elog "anymore."
	elog "You're currently invited to use either >=kde-base/kopete-3.5.3-r2, >=net-im/kopete-0.12.0-r2"
	elog "or >=kde-base/kdenetwork-3.5.2-r2 that are patched to support the new authentication."
	elog "For more information, please look at the following bugs:"
	elog "	  http://bugs.kde.org/show_bug.cgi?id=130630"
	elog "	  http://bugs.gentoo.org/show_bug.cgi?id=140009"
}
