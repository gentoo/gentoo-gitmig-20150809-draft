# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/smartmontools/smartmontools-9999.ebuild,v 1.1 2009/09/23 03:19:34 robbat2 Exp $

EAPI="2"

if [[ ${PV} == "9999" ]] ; then
	ESVN_REPO_URI="https://smartmontools.svn.sourceforge.net/svnroot/smartmontools/trunk/smartmontools"
	ESVN_PROJECT="smartmontools"
	ECLASS_NEED='subversion autotools'
	SRC_URI=""
else
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
fi
inherit flag-o-matic ${ECLASS_NEED}

DESCRIPTION="control and monitor storage systems using the Self-Monitoring, Analysis and Reporting Technology System (S.M.A.R.T.)"
HOMEPAGE="http://smartmontools.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE="static minimal"

RDEPEND="!minimal? ( virtual/mailx )"
DEPEND=""

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		subversion_src_unpack
	else
		unpack ${A}
	fi
}

src_prepare() {
	if [[ ${PV} == "9999" ]]; then
		#./autogen.sh
		eautoreconf
	fi
}

src_configure() {
	use minimal && einfo "Skipping the monitoring daemon for minimal build."
	use static && append-ldflags -static
	econf || die
}

src_compile() {
	emake || die
}

src_install() {
	dosbin smartctl || die "dosbin smartctl"
	dodoc AUTHORS CHANGELOG NEWS README TODO WARNINGS
	doman smartctl.8
	if ! use minimal; then
		dosbin smartd || die "dosbin smartd"
		doman smartd*.[58]
		newdoc smartd.conf smartd.conf.example
		docinto examplescripts
		dodoc examplescripts/*
		rm -f "${D}"/usr/share/doc/${PF}/examplescripts/Makefile*

		insinto /etc
		doins smartd.conf

		newinitd "${FILESDIR}"/smartd.rc smartd
		newconfd "${FILESDIR}"/smartd.confd smartd
	fi
}
