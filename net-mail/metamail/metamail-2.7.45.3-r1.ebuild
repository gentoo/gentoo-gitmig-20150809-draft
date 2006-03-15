# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/metamail/metamail-2.7.45.3-r1.ebuild,v 1.3 2006/03/15 16:36:40 corsair Exp $

inherit eutils

IUSE=""

MY_PV=${PV%.*.*}-${PV#*.*.}
S=${WORKDIR}/mm${PV%.*.*}/src
DESCRIPTION="Metamail (with Debian patches) - Generic MIME package"
HOMEPAGE="ftp://thumper.bellcore.com/pub/nsb/"
SRC_URI="ftp://thumper.bellcore.com/pub/nsb/mm${PV%.*.*}.tar.Z
	mirror://debian/pool/main/m/metamail/metamail_${MY_PV}.diff.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ~hppa ~ia64 ~ppc ppc64 ~s390 ~sparc ~x86"

DEPEND="sys-libs/ncurses
	app-arch/sharutils
	net-mail/mailbase"
RDEPEND="app-misc/mime-types"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/metamail_${MY_PV}.diff
	epatch $FILESDIR/${P}-CVE-2006-0709.patch
	chmod +x ${S}/configure
}

src_compile() {
	export WANT_AUTOCONF=2.5
	econf || die
	emake || die
}
src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING CREDITS README
	rm man/mmencode.1
	doman man/* debian/mimencode.1 debian/mimeit.1
}
