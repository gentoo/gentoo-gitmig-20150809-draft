# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-imagepack/nagios-imagepack-1.0.ebuild,v 1.8 2004/10/25 03:07:35 weeve Exp $

DESCRIPTION="Nagios imagepacks - Icons and pictures for Nagios"
HOMEPAGE="http://www.nagios.org"
IMAGE_URI="mirror://sourceforge/nagios/"
SRC_URI="
	${IMAGE_URI}/imagepak-andrade.tar.gz
	${IMAGE_URI}/imagepak-base.tar.gz
	${IMAGE_URI}/imagepak-bernhard.tar.gz
	${IMAGE_URI}/imagepak-didier.tar.gz
	${IMAGE_URI}/imagepak-remus.tar.gz
	${IMAGE_URI}/imagepak-satrapa.tar.gz
	${IMAGE_URI}/imagepak-werschler.tar.gz
"


SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc ~amd64"

RDEPEND="net-analyzer/nagios-core"

IUSE=""

src_unpack() {
	local bn
	mkdir ${S}
	cd ${S}
	for i in ${SRC_URI} ; do
		bn=`basename $i`
			unpack ${bn}
	done
}

src_compile() {
	einfo "No compilation necessary."
}

src_install () {
	insinto /usr/nagios/share/images/logos
	doins base/* didier/* imagepak-andrade/* imagepak-bernhard/* remus/* satrapa/* werschler/*
}
