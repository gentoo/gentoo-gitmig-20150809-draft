# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/run-mailcap/run-mailcap-3.23_p1.ebuild,v 1.1 2003/05/05 10:08:43 twp Exp $

MY_PV="${PV/_p/-}"
DESCRIPTION="Execute programs via entries in the mailcap file"
HOMEPAGE="http://packages.debian.org/unstable/net/mime-support.html"
SRC_URI="http://ftp.debian.org/debian/pool/main/m/mime-support/mime-support_${MY_PV}.tar.gz"
LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc "
IUSE=""
DEPEND=""
RDEPEND=">=perl-5.6*"

S=${WORKDIR}/mime-support

src_compile() {
	cp run-mailcap.man run-mailcap.1 || die "cp failed"
}

src_install() {
	dobin run-mailcap
	doman run-mailcap.1
}
