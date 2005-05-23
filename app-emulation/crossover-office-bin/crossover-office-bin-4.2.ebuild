# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/crossover-office-bin/crossover-office-bin-4.2.ebuild,v 1.2 2005/05/23 16:37:57 herbs Exp $

inherit eutils

DESCRIPTION="specialized version of wine for MS Office"
HOMEPAGE="http://www.codeweavers.com/site/products/cxoffice/"
SRC_URI="install-crossover-standard-${PV}.sh"

LICENSE="CROSSOVER"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="fetch nostrip"

RDEPEND="virtual/x11
	virtual/libc
	amd64? ( app-emulation/emul-linux-x86-xlibs )"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please visit ${HOMEPAGE}"
	einfo "and place ${A} in ${DISTDIR}"
}

pkg_setup() {
	! built_with_use dev-lang/perl ithreads \
		&& die "you need to have perl built with USE=ithreads"
}

src_unpack() {
	unpack_makeself
}

src_install() {
	dodir /opt/cxoffice
	cp -r * "${D}"/opt/cxoffice || die "cp failed"
	rm -r "${D}"/opt/cxoffice/setup.{sh,data}
	insinto /opt/cxoffice/etc
	doins support/templates/cxoffice.conf
}
