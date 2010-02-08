# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-summary/syslog-summary-1.14.ebuild,v 1.1 2010/02/08 12:38:01 phajdan.jr Exp $

EAPI=2
NEED_PYTHON="2.5"

inherit eutils python

DESCRIPTION="Summarizes the contents of a syslog log file."
HOMEPAGE="http://github.com/dpaleino/syslog-summary"
SRC_URI="http://cloud.github.com/downloads/dpaleino/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_prepare() {
	python_convert_shebangs 2 syslog-summary

	# Sadly, the makefile is useless for us.
	rm Makefile || die "rm failed"
}

src_install() {
	dobin syslog-summary
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
	doman syslog-summary.1 || die "doman failed"

	insinto /etc/syslog-summary
	doins ignore.rules || die "doins failed"
}
