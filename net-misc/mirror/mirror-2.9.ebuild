# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mirror/mirror-2.9.ebuild,v 1.5 2004/07/15 03:03:58 agriffis Exp $

inherit eutils

DESCRIPTION="FTP mirror utility"
HOMEPAGE="http://sunsite.org.uk/packages/mirror/"
SRC_URI="ftp://sunsite.org.uk/packages/mirror/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 alpha ~sparc ~ppc"
IUSE=""

S=${WORKDIR}

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	perl install.pl here <<EOC || die "perl install.pl here failed"
/usr/bin/perl
${S}
${S}
EOC
}

src_install() {
	dodir /etc/mirror
	insinto /etc/mirror
	doins mirror.defaults packages/sunsite.org.uk
	dodir /usr/lib/${P}
	insinto /usr/lib/${P}
	doins dateconv.pl ftp.pl lchat.pl lsparse.pl socket.ph
	dobin mirror mm pkgs_to_mmin prune_logs do_unlinks
	dohtml *.html
	dodoc *.txt
	newman mirror.man mirror.1
	newman mm.man mm.1

	einfo
	einfo "Defaults and sample config are in /etc/mirror."
	einfo
}
