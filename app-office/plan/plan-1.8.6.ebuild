# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/plan/plan-1.8.6.ebuild,v 1.3 2004/03/19 04:08:31 weeve Exp $

S="${WORKDIR}/${P}/src"
DESCRIPTION="Motif based schedule planner"
HOMEPAGE="http://www.bitrot.de/plan.html"
SRC_URI="ftp://plan.ftp.fu-berlin.de/${P}.tar.gz"

KEYWORDS="~x86 ~sparc"
LICENSE="as-is"
SLOT="0"

DEPEND="virtual/x11
	x11-libs/openmotif"

src_unpack() {

	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.tar.bz2

}

src_compile() {

	make linux || die "make failed"

}
src_install() {

	make DESTDIR=${D} install || die
	keepdir /usr/share/plan/netplan.dir

	cd ${S}/..
	dodoc HISTORY README || die "dodoc failed"

	cd ${S}/../misc
	doman netplan.1 plan.1 plan.4 || die "doman failed"

	insinto /usr/share/${PN}/misc
	doins netplan.boot BlackWhite Monochrome plan.fti Plan.xpm plan.xpm \
		|| die "misc files install failed"
	exeinto /usr/share/${PN}/misc
	doexe Killpland cvs vsc msschedule2plan plan2vcs || die "misc files install failed"

	cd ${S}/../web
	insinto /usr/share/${PN}/web
	doins help.html bottom.html cgi-lib.pl common.pl holiday_webplan rtsban.jpg \
		|| die "webplan install failed"
	exeinto /usr/share/${PN}/web
	doexe *.cgi || die "webplan install failed"
}

pkg_postinst() {
	einfo
	einfo " Check /usr/share/${PN}/holiday for examples to set your"
	einfo " ~/.holiday according to your country."
	einfo
	einfo " WebPlan 1.8 can be found in /usr/share/${PN}/web."
	einfo
}
