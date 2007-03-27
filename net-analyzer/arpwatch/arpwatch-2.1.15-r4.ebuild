# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/arpwatch/arpwatch-2.1.15-r4.ebuild,v 1.1 2007/03/27 19:33:47 pva Exp $

inherit eutils versionator

PATCH_VER="0.4"

MY_P="${PN}-$(replace_version_separator 2 'a')"
DESCRIPTION="An ethernet monitor program that keeps track of ethernet/ip address pairings"
HOMEPAGE="http://www-nrg.ee.lbl.gov/"
SRC_URI="ftp://ftp.ee.lbl.gov/${MY_P}.tar.gz
	mirror://gentoo/arpwatch-patchset-${PATCH_VER}.tbz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE="selinux"

DEPEND="virtual/libpcap
	sys-libs/ncurses"

RDEPEND="${DEPEND}
		selinux? ( sec-policy/selinux-arpwatch )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SOURCE="${WORKDIR}"/arpwatch-patchset/
	EPATCH_SUFFIX="patch"
	epatch
	cp "${WORKDIR}"/arpwatch-patchset/*.8 . || die "Failed to get man-pages from arpwatch-patchset."
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	dosbin arpwatch arpsnmp arp2ethers massagevendor arpfetch bihourly.sh
	doman arpwatch.8 arpsnmp.8 arp2ethers.8 massagevendor.8 arpfetch.8 bihourly.8

	insinto /usr/share/arpwatch
	doins ethercodes.dat

	insinto /usr/share/arpwatch/awk
	doins duplicates.awk euppertolower.awk p.awk e.awk d.awk

	keepdir /var/lib/arpwatch
	dodoc README CHANGES

	newinitd "${FILESDIR}"/arpwatch.init-2 arpwatch
	newconfd "${FILESDIR}"/arpwatch.confd arpwatch
}

pkg_config() {
	enewgroup arpwatch
	enewuser arpwatch -1 -1 /var/lib/arpwatch arpwatch

	einfo "Setting permitions for data directory"
	chown -R arpwatch:arpwatch /var/lib/arpwatch

	cat >> /etc/conf.d/arpwatch << EOF

# Uncomment this line if you wish arpwatch to drop privileges.
ARPUSER="arpwatch"
EOF
	einfo "Done."
}

pkg_postinst() {
	elog "For security reasons it is better to run arpwatch as an unprivileged user."
	elog "If you wish to do so, please, run:"
	elog "      emerge --config arpwatch"
	echo
	ewarn "Note: some scripts require snmpwalk utility from net-analyzer/net-snmp"
}
