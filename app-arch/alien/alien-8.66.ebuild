# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/alien/alien-8.66.ebuild,v 1.2 2007/05/14 10:39:24 lordvan Exp $

inherit perl-app

DESCRIPTION="Converts between the rpm, dpkg, stampede slp, and slackware tgz file formats"
HOMEPAGE="http://kitenet.net/programs/alien/"
SRC_URI="mirror://debian/pool/main/a/alien/${PN}_${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.0
	>=app-arch/rpm-4.0.4-r4
	>=app-arch/bzip2-1.0.2-r2
	>=app-arch/dpkg-1.10.9"

S=${WORKDIR}/${PN}

src_compile() {
	sed -i s%'$(VARPREFIX)'%${D}% ${S}/Makefile.PL # Extutils::MakeMaker does not accept VARPREFIX
	perl Makefile.PL PREFIX="${D}/usr" || die "configuration failed"
	emake || die "emake failed."
}