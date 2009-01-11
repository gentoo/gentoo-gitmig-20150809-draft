# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ksensors/ksensors-0.7.3-r2.ebuild,v 1.1 2009/01/11 08:01:40 gengor Exp $

inherit kde

DESCRIPTION="KSensors - a nice lm_sensors frontend for KDE"
SRC_URI="mirror://sourceforge/ksensors/${P}.tar.gz
		mirror://debian/pool/main/k/ksensors/${PN}_${PV}-16.diff.gz"
HOMEPAGE="http://ksensors.sourceforge.net/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hddtemp ibmacpi"

DEPEND=">=sys-apps/lm_sensors-2.6.3"

RDEPEND="${DEPEND}
		hddtemp? ( >=app-admin/hddtemp-0.3_beta15-r1 )"

need-kde 3

src_unpack() {
	kde_src_unpack

	cd ${WORKDIR}

	# Debian patchset, fixes bugs 120350, 171208, 173821, 232782
	epatch ${PN}_${PV}-16.diff

	# On Gentoo hddtemp resides in /usr/sbin which is not in the user's
	# path. Thus, call hddtemp with full path.
	use hddtemp && epatch ${FILESDIR}/${P}-hddtemp-path.patch

	# User-contributed patch, fixes bug 116661
	use ibmacpi && epatch ${FILESDIR}/${P}-ibm-acpi.patch
}

src_install() {
	kde_src_install

	dodoc README AUTHORS TODO ChangeLog FAQ INSTALL NEWS
	dodoc LEEME LIESMICH LISEZMOI

	docinto debian
	dodoc debian/{changelog,copyright}
	doman debian/ksensors.1

	# Remove obsolete menu entry
	rm -fR ${D}/usr/share/applnk/

	insinto /usr/share/applications/kde
	doins ${FILESDIR}/ksensors.desktop
}

pkg_postinst() {
	kde_pkg_postinst

	if use hddtemp; then
		[[ -u "${ROOT}"/usr/sbin/hddtemp ]] || \
			elog "You need to run \"chmod u+s /usr/sbin/hddtemp\" to show disk temperatures."
	fi
}
