# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/neti/neti-2.0.ebuild,v 1.1 2006/07/20 11:41:58 dragonheart Exp $

DESCRIPTION="NETI@Home research project from GATech"
HOMEPAGE="http://www.neti.gatech.edu"
SRC_URI="mirror://sourceforge/neti/${P}.tar.gz"
KEYWORDS="~ppc ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="zlib java"
RDEPEND="java? ( || ( >=virtual/jdk-1.2 >=virtual/jre-1.2 ) )
	virtual/libc"
DEPEND="${RDEPEND}"
RESTRICT="test"

src_compile() {
	econf \
		$(use_with zlib) \
		 || die "failed to configure"

	emake NETILogParse neti \
		|| die "failed to make"

	if use java;
	then
		emake javadir=/usr/share/${PN} classjava.stamp
	fi
}

src_install() {
	emake DESTDIR="${D}" install-sbinPROGRAMS \
		install-sysconfDATA install-man install-info || die "install failed"

	if use java;
	then
		emake javadir=/usr/share/${PN} \
			 DESTDIR="${D}" install-javaJAVA install-javaDATA || die "java install failed"
		dobin /usr/bin
		echo cd /usr/share/${PN}\;java -cp /usr/share/${PN} NETIMap > "${D}"/usr/bin/NETIMap
		fperms ugo+x /usr/bin/NETIMap
	fi

	dodoc README AUTHORS
	exeinto /etc/init.d
	newexe "${FILESDIR}"/neti-init2 neti
}
