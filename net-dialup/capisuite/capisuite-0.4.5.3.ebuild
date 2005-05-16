# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/capisuite/capisuite-0.4.5.3.ebuild,v 1.1 2005/05/16 08:37:31 genstef Exp $

inherit eutils versionator

MY_PV="$(get_version_component_range 1-3)"
MY_PL="$(get_version_component_range 4)"
MY_PT="${PN}_${MY_PV}-${MY_PL}"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Python-scriptable ISDN telecommunication suite"
HOMEPAGE="http://www.capisuite.de"
SRC_URI="http://www.capisuite.de/${MY_P}.tar.gz
	http://ftp.debian.org/debian/pool/main/c/capisuite/${MY_PT}.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="dev-lang/python
	virtual/libc
	media-sound/sox
	media-libs/tiff
	media-gfx/jpeg2ps
	media-gfx/sfftobmp
	virtual/ghostscript"
RDEPEND="${DEPEND}
	net-dialup/capi4k-utils
	virtual/mta"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${MY_PT}.diff
	epatch ${FILESDIR}/${MY_P}-gentoo.patch
	# apply CAPI V3 patch conditionally
	grep 2>/dev/null -q CAPI_LIBRARY_V2 /usr/include/capiutils.h \
		&& epatch ${FILESDIR}/${MY_P}-capiv3.patch
	epatch ${FILESDIR}/${PN}-fax-compatibility.patch
}

src_compile() {
	econf --localstatedir=/var \
		--with-docdir=/usr/share/doc/${PF} || die "econf failed."
	emake || die "parallel make failed."
}

src_install() {
	make DESTDIR=${D} install || die "install failed."

	dodir /etc/init.d
	newinitd ${FILESDIR}/capisuite.initd capisuite

	keepdir /var/spool/capisuite/{done,failed,sendq,users}

	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
	newdoc debian/changelog ChangeLog.debian

	exeinto /etc/cron.daily
	doexe capisuite.cron
	insinto /etc/capisuite
	doins cronjob.conf
	insinto /etc/logrotate.d
	newins debian/capisuite.logrotate capisuite
}
