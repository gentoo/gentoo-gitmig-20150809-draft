# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/polipo/polipo-0.9.8.ebuild,v 1.1 2005/03/26 14:14:56 mrness Exp $

inherit eutils

DESCRIPTION="A caching web proxy"
HOMEPAGE="http://www.pps.jussieu.fr/~jch/software/polipo/"
SRC_URI="http://www.pps.jussieu.fr/~jch/software/files/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc
	sys-apps/texinfo"
RDEPEND="${DEPEND}
	app-admin/sudo"

pkg_setup() {
	enewgroup polipo
	enewuser polipo -1 /bin/false /var/cache/polipo polipo
}

src_unpack() {
	unpack ${A}

	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	emake "PREFIX=/usr" "CDEBUGFLAGS=${CFLAGS}" all || die "build failed"
}

src_install() {
	einstall "PREFIX=/usr" "TARGET=${D}" || die "install failed"
	mv polipo.man polipo.1
	doman ${S}/polipo.1
	doinfo ${S}/polipo.info

	exeinto /etc/init.d ; newexe ${FILESDIR}/polipo.initd polipo
	insinto /etc/polipo ; doins ${FILESDIR}/config
	insinto /etc/cron.daily ; newins ${FILESDIR}/polipo.crond polipo.sh

	diropts -m0750 -o polipo -g polipo
	dodir /var/cache/polipo
}

pkg_preinst() {
	pkg_setup
}

pkg_postinst() {
	einfo "Do not forget to read the manual."
	einfo "Change the config file in /etc/polipo to suit your needs."
}
