# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/fmirror/fmirror-0.8.4-r1.ebuild,v 1.1 2005/04/06 20:03:46 seemant Exp $

inherit eutils

DESCRIPTION="FTP mirror utility"
HOMEPAGE="http://freshmeat.net/projects/fmirror"
SRC_URI="ftp://ftp.guardian.no/pub/free/ftp/fmirror/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

RDEPEND=""
DEPEND=""

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${PN}-crlf.patch
}

src_compile() {
	econf \
		--datadir=/etc/fmirror \
	|| die "configure problem"

	emake || die "compile problem"
}

src_install() {
	into /usr
	dobin fmirror
	dodoc COPYING ChangeLog README
	newdoc configs/README README.sample
	doman fmirror.1

	cd configs
	insinto /etc/fmirror/sample
	doins {sample,generic,redhat}.conf
}
