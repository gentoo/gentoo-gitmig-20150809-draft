# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/prelude-nagios/prelude-nagios-0.0.2.ebuild,v 1.4 2004/03/20 06:37:02 mboman Exp $

inherit eutils

DESCRIPTION="Plugin for Nagios to talk with Prelude"
HOMEPAGE="http://www.exaprobe.com/labs/downloads/index.php3?DIR=/downloads/Nagios_Plugin"
SRC_URI="http://www.exaprobe.com/labs/downloads/Nagios_Plugin/prelude-nagios-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="
	|| ( dev-libs/libprelude dev-libs/libprelude-cvs )"
RDEPEND="${DEPEND}
	net-analyzer/nagios-core"

S=${WORKDIR}/${P}

src_unpack() {
	# prelude-nagios-0.0.2.tar.gz is a POSIX tar archive from exaprobe
	# In the future I think we should to try to avoid calling
	# tar directly from ebuilds.

	# Our possible solutions.
	# 1) email exaprobe and inform them that the .tar.gz is only a .tar
	# 2) Repackage the tarball as a .bz2 and put it on a gentoo mirror

	tar xvf ${DISTDIR}/${A} -C ${WORKDIR}
	#unpack ${A}
	epatch ${FILESDIR}/prelude-nagios-${PV}-001.patch
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	insinto /etc/prelude-nagios
	doins prelude-nagios.conf

	exeinto /usr/nagios/bin
	doexe src/prelude-nagios
}
