# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/qrna/qrna-2.0.2c.ebuild,v 1.2 2004/07/21 18:31:13 dholm Exp $

DESCRIPTION="Prototype ncRNA genefinder"
HOMEPAGE="http://www.genetics.wustl.edu/eddy/software/"
SRC_URI="ftp://ftp.genetics.wustl.edu/pub/eddy/software/qrna.tar.Z"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="perl"

DEPEND="perl? ( dev-lang/perl )
	virtual/glibc"

src_compile () {
	cd ${S}/squid
	emake || die
	cd ${S}/src
	emake || die
}

src_install () {
	dobin src/qrna
	use perl && dobin scripts/*

	newdoc 00README README
	insinto /usr/share/doc/${PF}
	doins documentation/*

	insinto /usr/share/${PN}/data
	doins lib/*
	insinto /usr/share/${PN}/demos
	doins Demos/*

	# Sets the path to the QRNA data files.
	insinto /etc/env.d
	doins ${FILESDIR}/26qrna
}
