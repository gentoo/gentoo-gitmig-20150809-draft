# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capisuite/capisuite-0.4.5.ebuild,v 1.6 2006/04/11 23:02:37 sbriesen Exp $

inherit eutils

DESCRIPTION="An ISDN telecommunication suite"
HOMEPAGE="http://www.capisuite.de"
SRC_URI="http://www.capisuite.de/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="dev-lang/python
	virtual/libc
	media-sound/sox
	>=media-libs/tiff-3.7.1
	media-gfx/jpeg2ps
	media-gfx/sfftobmp
	virtual/ghostscript
	net-dialup/capi4k-utils"
RDEPEND="${DEPEND}
	virtual/mta"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${PN}-fax-compatibility.patch
	# apply CAPI V3 patch conditionally
	grep 2>/dev/null -q CAPI_LIBRARY_V2 /usr/include/capiutils.h \
		&& epatch ${FILESDIR}/${P}-capiv3.patch
}

src_compile() {
	econf --localstatedir=/var \
		--with-docdir=/usr/share/doc/${PF} || die "econf failed."
	emake || die "parallel make failed."
}

src_install() {
	emake DESTDIR=${D} install || die "install failed."

	dodir /etc/init.d
	doinitd ${FILESDIR}/capisuite

	keepdir /var/spool/capisuite/{done,failed,sendq,users}

	dodoc AUTHORS ChangeLog NEWS README TODO

	exeinto /etc/cron.daily
	doexe capisuite.cron
	insinto /etc/capisuite
	doins cronjob.conf
}
