# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/reoback/reoback-1.0_rc3.ebuild,v 1.1 2005/01/14 00:48:14 vapier Exp $

DESCRIPTION="Reoback Backup Solution"
HOMEPAGE="http://reoback.sourceforge.net/"
SRC_URI="mirror://sourceforge/reoback/reoback-${PV/rc/r}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.1"
DEPEND=">=app-arch/tar-1.13"

src_install() {
	find -name CVS -type d | exec rm -r

	dosbin reoback.pl || die "dosbin"
	fperms 750 /usr/sbin/reoback.pl /etc/reoback/run_reoback.sh

	insinto /etc/reoback
	doins run_reoback.sh conf/* || die "doins conf"

	cd docs
	dodoc BUGS CHANGES INSTALL MANUALS README TODO
}
