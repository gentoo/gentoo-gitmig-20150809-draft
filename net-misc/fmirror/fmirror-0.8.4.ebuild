# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/fmirror/fmirror-0.8.4.ebuild,v 1.9 2004/07/15 02:49:31 agriffis Exp $

DESCRIPTION="FTP mirror utility"
HOMEPAGE="http://freshmeat.net/projects/fmirror"
SRC_URI="ftp://ftp.guardian.no/pub/free/ftp/fmirror/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "
IUSE=""

RDEPEND=""
DEPEND=""

src_compile() {
	./configure \
		--prefix=/usr \
		--datadir=/etc/fmirror \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
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
	doins sample.conf generic.conf redhat.conf
}
