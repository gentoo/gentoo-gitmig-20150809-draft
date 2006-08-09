# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/leafnode/leafnode-2.0.0_alpha20060711.ebuild,v 1.1 2006/08/09 18:54:15 swegener Exp $

inherit flag-o-matic

MY_P=${P/_/.}a

DESCRIPTION="A USENET software package designed for small sites"
SRC_URI="http://www-dt.e-technik.uni-dortmund.de/~ma/leafnode/beta/${MY_P}.tar.bz2"
HOMEPAGE="http://www-dt.e-technik.uni-dortmund.de/~ma/leafnode/beta/"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="ipv6 pam"

DEPEND=">=dev-libs/libpcre-3.9
	pam? ( sys-libs/pam )"
RDEPEND="${DEPEND}
	virtual/inetd"

S="${WORKDIR}/${MY_P}"

src_compile() {
	append-ldflags $(bindnow-flags)

	econf \
		--sysconfdir=/etc/leafnode \
		--with-runas-user=news \
		--localstatedir=/var \
		--with-spooldir=/var/spool/news \
		$(use_with ipv6) \
		$(use_with pam) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	keepdir \
		/var/lock/news \
		/var/lib/news \
		/var/spool/news

	insinto /etc/leafnode
	doins "${FILESDIR}"/{local.groups,moderators} || die "doins failed"

	insinto /etc/xinetd.d
	newins "${FILESDIR}"/leafnode.xinetd leafnode-nntp || die "newins failed"

	exeinto /etc/cron.hourly
	newexe "${FILESDIR}"/fetchnews.cron fetchnews || die "doexe failed"
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/texpire.cron texpire || die "doexe failed"

	dodoc \
		AUTHORS COPYING* CREDITS ChangeLog DEBUGGING ENVIRONMENT \
		INSTALL NEWS TODO README || die "dodoc failed"
	dohtml README.html || die "dohtml failed"
}
