# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-power/powerman/powerman-1.0.20.ebuild,v 1.1 2006/10/01 21:42:34 robbat2 Exp $

inherit eutils

DESCRIPTION="PowerMan - Power to the Cluster"
HOMEPAGE="http://www.llnl.gov/linux/powerman/"
SRC_URI="ftp://ftp.llnl.gov/pub/linux/${PN}/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="sys-devel/bison
		dev-lang/perl"
RDEPEND=">=sys-libs/freeipmi-0.2.3"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-new-yacc.patch
	sed -i.orig \
		-e "/^CFLAGS/s#-g#-g ${CFLAGS} #g" \
		${S}/src/Makefile \
		|| die "couldn't set custom CFLAGS"
	sed -i.orig \
		-e "s,PTHREAD_THREADS_MAX,32768,g" \
		${S}/test/vpcd.c \
		|| die "Couldn't set pthreads max"
}

src_compile() {
	emake 
}

src_install() {
	emake -j1 install DESTDIR="${D}" mandir="/usr/share/man"
	rm ${D}/etc/rc.d/init.d/powerman
	newdoc scripts/powerman.init powerman_redhat_initd
	dodoc ChangeLog DISCLAIMER NEWS TODO
}

# Sorry, you need to be root :-(
#src_test () {
#	cd ${S}/test
#	for i in 64 4096 8192 16384 64t 4096t 8192t 16384t; do
#		einfo "Testing mode: $i"
#		emake -j1 run$i || die "Failed test: $ti"
#	done
#}
