# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/neti/neti-1.01.ebuild,v 1.7 2005/01/29 19:26:00 dragonheart Exp $

DESCRIPTION="NETI@Home research project from GATech"
HOMEPAGE="http://www.neti.gatech.edu"
SRC_URI="mirror://sourceforge/neti/${P}.tar.gz"
KEYWORDS="x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"

IUSE="zlib java"

RDEPEND="java? ( || ( >=virtual/jdk-1.2 >=virtual/jre-1.2 ) )
	virtual/libpcap
	net-analyzer/ethereal
	virtual/libc"

DEPEND="java? ( >=virtual/jdk-1.2 )
	virtual/libpcap
	virtual/libc
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/gcc"

src_compile() {
	econf \
		`use_with zlib` \
		 || die "failed to configure"

	emake NETILogParse neti \
		|| die "failed to make"

	if use java;
	then
		emake javadir=/usr/share/${PN} classjava.stamp
	fi
}

src_install() {
	emake DESTDIR=${D} install-sbinPROGRAMS install-sbinSCRIPTS \
		install-sysconfDATA install-man || die "install failed"

	if use java;
	then
		emake javadir=/usr/share/${PN} \
			 DESTDIR=${D} install-javaJAVA install-javaDATA || die "java install failed"
	fi

	dobin /usr/bin
	echo java -cp /usr/share/${PN} NETIMap > ${D}/usr/bin/NETIMap
	fperms ugo+x /usr/bin/NETIMap
	dodoc COPYING
	exeinto /etc/init.d
	newexe ${FILESDIR}/neti-init neti
}
