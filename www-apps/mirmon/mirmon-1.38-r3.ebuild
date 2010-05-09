# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mirmon/mirmon-1.38-r3.ebuild,v 1.2 2010/05/09 22:07:32 darkside Exp $

inherit webapp eutils

DESCRIPTION="Simple webapp to monitor the status of mirrors"
HOMEPAGE="http://people.cs.uu.nl/henkp/mirmon/"
SRC_URI="http://people.cs.uu.nl/henkp/mirmon/src/$PN/src/$P.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.5-r2"
RDEPEND="${DEPEND}
	dev-perl/File-Tempdir
	dev-perl/Socket6"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/0001-Add-rsync-monitoring-support-to-mirmon.patch" \
		"${FILESDIR}/0002-Add-ipv6-monitor-support-to-mirmon.patch"
}

src_install() {
	# Don't install empty dirs
	MY_CGIBINDIR=""
	MY_ICONSDIR=""
	MY_ERRORSDIR=""

	webapp_src_preinst

	for file in mirmon.html mirmon.txt; do
		dodoc ${file}
		rm -f ${file}
	done
	cp -R icons mirmon.html "${D}"/${MY_HTDOCSDIR}
	rm -rf icons mirmon.html
	cp -R . "${D}"/${MY_HOSTROOTDIR}

	webapp_src_install
}
