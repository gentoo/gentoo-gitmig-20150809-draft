# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/dansguardian-dgav/dansguardian-dgav-6.4.4.ebuild,v 1.2 2006/05/04 04:36:50 squinky86 Exp $

inherit eutils

DG_PN=${PN/-*/}
AV_PN=${PN/*-/}
DG_PV=2.8.0.6

DESCRIPTION="DansGuardian with Anti-Virus plugin"
HOMEPAGE="http://sourceforge.net/projects/dgav/"
SRC_URI="http://mirror.dansguardian.org/downloads/2/Stable/${DG_PN}-${DG_PV}.source.tar.gz
	mirror://sourceforge/${AV_PN}/${DG_PN}-${DG_PV}-antivirus-${PV}.patch.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="!net-proxy/dansguardian
	net-libs/libesmtp
	app-antivirus/clamav"

S="${WORKDIR}/${DG_PN}-${DG_PV}"

src_unpack() {
	unpack ${A}

	cd "${S}" || die "source dir not found"
	epatch "../${DG_PN}-${DG_PV}-antivirus-${PV}.patch"
	epatch "${FILESDIR}/${P}-xnaughty.patch"
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_compile() {
	./configure \
		--prefix= \
		--installprefix="${D}" \
		--mandir=/usr/share/man/ \
		--cgidir=/var/www/localhost/cgi-bin/ \
		--logrotatedir="${D}/etc/logrotate.d" \
		--with-av-engine=clamdscan,aveserver,trophie,sophie \
		--runas_usr=clamav --runas_grp=clamav || die "./configure failed"
	emake OPTIMISE="${CFLAGS}" || die "emake failed"
}

src_install() {
	make install || die "make install failed"

	newinitd "${FILESDIR}/dansguardian.init" dansguardian

	insinto /etc/logrotate.d
	newins "${FILESDIR}/dansguardian.logrotate" dansguardian

	doman dansguardian.8
	dodoc README*

	#Create log directory
	diropts -m0700 -o clamav
	keepdir /var/log/dansguardian
}
