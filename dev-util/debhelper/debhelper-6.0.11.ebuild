# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debhelper/debhelper-6.0.11.ebuild,v 1.1 2008/04/09 03:18:27 vapier Exp $

inherit perl-module

DESCRIPTION="helper programs for debian/rules"
HOMEPAGE="http://kitenet.net/~joey/code/debhelper/"
SRC_URI="mirror://debian/pool/main/d/${PN}/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

S="${WORKDIR}/${PN}"

src_install() {
	dobin dh_* || die
	insinto /usr/share/debhelper
	doins -r autoscripts || die
	dodoc doc/* examples/*
	insinto ${VENDOR_LIB}
	doins -r Debian || die
}
