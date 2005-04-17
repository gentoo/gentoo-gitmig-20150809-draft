# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-rss/cl-rss-0.1.1.ebuild,v 1.4 2005/04/17 00:39:30 mkennedy Exp $

inherit common-lisp

DESCRIPTION="CL-RSS is a Common Lisp library for fetching and parsing Remote Site Summary data via HTTP"
HOMEPAGE="http://files.b9.com/cl-rss/
	http://packages.debian.org/unstable/devel/cl-rss
	http://packages.qa.debian.org/c/cl-rss.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/c/${PN}/${PN}_${PV}.orig.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"
IUSE=""
DEPEND="dev-lisp/cl-aserve
	dev-lisp/cl-kmrcl
	dev-lisp/cl-ptester
	dev-lisp/cl-xmls"

CLPACKAGE=rss

src_install() {
	common-lisp-install *.lisp *.asd
	common-lisp-system-symlink
}
