# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/hap/hap-3.7.ebuild,v 1.4 2004/11/24 09:53:15 ticho Exp $

IUSE=""

DESCRIPTION="A terminal mail notification program (replacement for biff)"
HOMEPAGE="http://www.transbay.net/~enf/sw.html"
SRC_URI="http://www.transbay.net/~enf/hap-3.7.tar"

DEPEND="sys-libs/libtermcap-compat"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~alpha"

# untars to 'hap/'
S="${WORKDIR}/${PN}"

src_compile() {

	# The configure script doesn't like --mandir etc., so we call it directly
	# rather than via econf
	./configure || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	dobin hap
	doman hap.1
}
