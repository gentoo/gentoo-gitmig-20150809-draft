# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/anacron/anacron-2.3.ebuild,v 1.4 2003/06/21 21:19:38 drobbins Exp $

#MY_P=${PN}-${PV}
#S=${WORKDIR}/${MY_P}
S=${WORKDIR}/${P}
DESCRIPTION="Anacron -- a periodic command scheduler"
SRC_URI=" http://umn.dl.sourceforge.net/sourceforge/anacron/${P}.tar.gz"
HOMEPAGE="http://anacron.sourceforge.net/"
KEYWORDS="x86 amd64 ppc"
SLOT="0"
LICENSE="as-is"

DEPEND="virtual/glibc"

RDEPEND="virtual/mta
	virtual/cron"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile Makefile.orig
	sed "s:^CFLAGS =:CFLAGS = $CFLAGS:" Makefile.orig >Makefile
}

src_compile() {
	emake || die
}

src_install() {
	#this does not work if the directory exists already
	diropts -m0750 -o root -g cron
	dodir /var/spool/anacron

	doman anacrontab.5 anacron.8

	exeinto /etc/init.d ; newexe ${FILESDIR}/anacron.rc6 anacron

	dodoc ChangeLog COPYING README TODO 

	insinto /usr/sbin
	insopts -o root -g root -m 0750 ; doins anacron

	insinto /etc 
	doins ${FILESDIR}/anacrontab
}

pkg_postinst() {
	einfo "Schedule the command "anacron -s" as a daily cron-job (preferably"
	einfo "at some early morning hour).  This will make sure that jobs are run"
	einfo "when the systems is left running for a night."
	einfo ""
	einfo "Update /etc/anacrontab to include what you want anacron to run."
}
