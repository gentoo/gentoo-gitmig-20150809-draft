# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/multiimonc/multiimonc-0.3.2.ebuild,v 1.2 2004/06/17 10:58:41 kloeri Exp $

inherit eutils

DESCRIPTION="A wxWidgets-based client for fli4l"
SRC_URI="http://www.fli4l.de/german/extern/multiimonc/MultiImonC-${PV}.tar.bz2"
HOMEPAGE="http://www.hansmi.ch/software/multiimonc"

S="${WORKDIR}/MultiImonC-${PV}"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=x11-libs/wxGTK-2.4.1
		virtual/glibc
		virtual/x11"

src_compile() {
	# Fix a divide-by-zero-error in UsagePlot.cpp
	( cd "${S}/src" && epatch "${FILESDIR}/UsagePlot-0.3.2.diff" )
	econf || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install problem"
}

