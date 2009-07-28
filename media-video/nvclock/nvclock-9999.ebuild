# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvclock/nvclock-9999.ebuild,v 1.1 2009/07/28 17:14:17 jer Exp $

EAPI="2"

inherit eutils autotools cvs

ECVS_SERVER="nvclock.cvs.sourceforge.net:/cvsroot/nvclock"
ECVS_MODULE="nvclock"
ECVS_USER="anonymous"
ECVS_PASS=""

DESCRIPTION="NVIDIA Overclocking Utility"
HOMEPAGE="http://www.linuxhardware.org/nvclock/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="gtk qt3"

RDEPEND="
	gtk? ( x11-libs/gtk+:2 )
	qt3? ( x11-libs/qt:3 )
"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	eautoreconf
}

src_configure() {
	# Needed to ensure it compiles against Qt3 rather than Qt4
	export QTDIR=/usr/qt/3
	export MOC=${QTDIR}/bin/moc

	econf $(use_enable qt3 qt) $(use_enable gtk) || die "econf failed"
}

src_compile() {
	# The build fails with -j[N>1]
	emake -j1 || die "emake failed"
}

src_install() {
	dodir /usr/bin
	einstall || die "einstall failed"
	dodoc AUTHORS README

	newinitd "${FILESDIR}"/nvclock_initd nvclock
	newconfd "${FILESDIR}"/nvclock_confd nvclock
}

pkg_postinst() {
	elog "To enable card overclocking at startup, edit your /etc/conf.d/nvclock"
	elog "accordingly and then run: rc-update add nvclock default"
}
