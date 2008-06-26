# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/at/at-3.1.8-r12.ebuild,v 1.7 2008/06/26 10:37:33 bangert Exp $

inherit eutils flag-o-matic

DESCRIPTION="Queues jobs for later execution"
HOMEPAGE="ftp://jurix.jura.uni-sb.de/pub/jurix/source/chroot/appl/at/"
SRC_URI="mirror://debian/pool/main/a/at/at_${PV}-11.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/mta
	>=sys-devel/flex-2.5.4a"
RDEPEND="virtual/mta
	virtual/logger"

pkg_setup() {
	enewgroup at 25
	enewuser at 25 -1 /var/spool/at/atjobs at
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-more-deny.patch
	epatch "${FILESDIR}"/${P}-makefile.patch
	epatch "${FILESDIR}"/${P}-longuser.patch
}

src_compile() {
	econf \
		--sysconfdir=/etc/at \
		--with-jobdir=/var/spool/at/atjobs \
		--with-atspool=/var/spool/at/atspool \
		--with-etcdir=/etc/at \
		--with-daemon_username=at \
		--with-daemon_groupname=at \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make install IROOT="${D}" || die
	touch "${D}"/var/spool/at/at{jobs,spool}/.SEQ

	newinitd "${FILESDIR}"/atd.rc6 atd
	prepalldocs
}
