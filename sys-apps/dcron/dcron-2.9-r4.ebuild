# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/dcron/dcron-2.9-r4.ebuild,v 1.1 2005/02/19 20:45:40 vapier Exp $

inherit cron toolchain-funcs

MY_PV=29
DESCRIPTION="A cute little cron from Matt Dillon"
HOMEPAGE="http://apollo.backplane.com/"
SRC_URI="http://apollo.backplane.com/FreeSrc/${PN}${MY_PV}.tgz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND=">=sys-apps/portage-2.0.51"
RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/dcron-2.9-Makefile.patch
	epatch "${FILESDIR}"/dcron-2.9-pidfile.patch

	# fix 'crontab -e' to look at $EDITOR and not $VISUAL
	sed -i 's:VISUAL:EDITOR:g' crontab.{c,1}

	# remove gcc hardcode
	sed -i "s:\(CC  = \)gcc:\1$(tc-getCC):" Makefile
}

src_compile() {
	make || die
}

src_install() {
	#this does not work if the directory already exists
	docrondir
	docron crond -m0700 -o root -g wheel
	docrontab

	dodoc CHANGELOG README ${FILESDIR}/crontab
	doman crontab.1 crond.8

	newinitd ${FILESDIR}/dcron-r4 dcron

	insinto /etc/logrotate.d
	newins ${FILESDIR}/dcron.logrotate dcron

	insopts -o root -g root -m 0644
	insinto /etc
	doins ${FILESDIR}/crontab
}

pkg_postinst() {
	echo
	einfo "To activate /etc/cron.{hourly|daily|weekly|montly} please run: "
	einfo "crontab /etc/crontab"
	echo
	einfo "!!! That will replace root's current crontab !!!"
	echo
	einfo "You may wish to read the Gentoo Linux Cron Guide, which can be"
	einfo "found online at:"
	einfo "    http://www.gentoo.org/doc/en/cron-guide.xml"
	echo
}
