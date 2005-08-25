# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.4.1-r1.ebuild,v 1.6 2005/08/25 15:29:08 agriffis Exp $

inherit kde-dist

DESCRIPTION="KDE network apps: kopete, kppp, kget..."

KEYWORDS="~alpha amd64 hppa ia64 ~mips ppc sparc x86"
IUSE="rdesktop slp ssl wifi"

DEPEND="~kde-base/kdebase-${PV}
	slp? ( net-libs/openslp )
	wifi? ( net-wireless/wireless-tools )"

RDEPEND="${DEPEND}
	rdesktop? ( >=net-misc/rdesktop-1.4.1 )
	dev-lang/perl
	ssl? ( app-crypt/qca-tls
	       dev-perl/IO-Socket-SSL )"
# perl: for KSirc
# qca-tls: for Kopete jabber plugin.
# IO-Socket-SSL: for SSL support in KSirc.

PATCHES="$FILESDIR/wireless-extensions-api.diff" # In cvs, remove for 3.4.2

# No meanwhile support in kopete. See bug 96778.
PATCHES="$PATCHES $FILESDIR/disable-meanwhile.diff"

SRC_URI="${SRC_URI}
	mirror://kde/security_patches/post-3.4.1-kdenetwork-libgadu.patch"

# Fix vulnerabilities in libgadu. See bug 99754.
PATCHES="$PATCHES $DISTDIR/post-3.4.1-kdenetwork-libgadu.patch"

src_compile() {
	myconf="$(use_enable slp)"
	use wifi || export DO_NOT_COMPILE="${DO_NOT_COMPILE} wifi"

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
