# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/i8kutils/i8kutils-1.25.ebuild,v 1.14 2012/07/01 11:03:09 jlec Exp $

EAPI=4

DESCRIPTION="Dell Inspiron and Latitude utilities"
HOMEPAGE="http://packages.debian.org/sid/i8kutils"
SRC_URI="http://people.debian.org/~dz/i8k/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE="tk"

DEPEND="tk? ( dev-lang/tk )"
RDEPEND="${DEPEND}"

src_compile() {
	make all || die
}

src_install() {
	dobin i8kbuttons i8kctl
	doman i8kbuttons.1 i8kctl.1
	dosym /usr/bin/i8kctl /usr/bin/i8kfan
	dodoc README.i8kutils
	docinto examples/
	dodoc examples/*

	newinitd "${FILESDIR}"/i8k.init i8k
	newconfd "${FILESDIR}"/i8k.conf i8k

	if use tk; then
		dobin i8kmon
		doman i8kmon.1
		docinto /
		dodoc i8kmon.conf
	else
		echo >> "${ED}"/etc/conf.d/i8k
		echo '# i8kmon disabled because the package was installed without USE=tk' >> "${ED}"/etc/conf.d/i8k
		echo 'NOMON=1' >> "${ED}"/etc/conf.d/i8k
	fi

}
