# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/digitemp/digitemp-3.3.1.ebuild,v 1.1 2004/02/02 20:42:11 mholzer Exp $

IUSE="perl python"

S=${WORKDIR}/${P}
DESCRIPTION="Temperature logging and reporting using Dallas Semiconductor's iButtons and 1-Wire protocol"
HOMEPAGE="http://www.digitemp.com http://www.ibutton.com"
SRC_URI="http://www.digitemp.com/software/linux/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc"

src_compile() {
	# default is to compile to the ds9097u. local use flag takes care of
	# passive ds9097. the ds9097u setting is what i have, so probably a safe
	# default - nothing special here.
	local target="ds9097u"
	[ "${SERIAL_DRIVER}" = ds9097 ] && target="ds9097"
	make clean

	ewarn ""
	ewarn "making for ${target} serial controller. if you would like support"
	ewarn "for another controller, please set SERIAL_DRIVER=\"ds9097u\" or"
	ewarn "SERIAL_DRIVER=\"ds9097\" as appropriate"
	ewarn ""

	make ${target}
}

src_install() {
	dobin digitemp
	dodoc README COPYING FAQ TODO

	# method one: don't treat the examples as docs; place them somewhere else.
	# then tell the user where to find this stuff. suitable alternative:
	# specify exampledir="/usr/share/doc/${PF}"

	local exampledir="/usr/share/${PN}"
	local perldir="${exampledir}/perl_examples"
	insinto ${perldir}
	doins perl/*
	local pythondir="${exampledir}/python_examples"
	insinto ${pythondir}
	doins python/*
	local rrdbdir="${exampledir}/rrdb_examples"
	insinto ${rrdbdir}
	doins rrdb/*
}

pkg_postinst() {
	ewarn "set the SERIAL_DRIVER environment variable to ds9097 to build"
	ewarn "for that controller instead"
	einfo ""
	einfo "examples of using digitemp with python, perl, and rrdtool are"
	einfo "located in ${exampledir}"
	einfo ""
}
