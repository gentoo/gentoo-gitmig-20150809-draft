# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/reoback/reoback-1.0_rc3-r1.ebuild,v 1.1 2005/03/13 09:56:07 vapier Exp $

DESCRIPTION="Reoback Backup Solution"
HOMEPAGE="http://reoback.sourceforge.net/"
SRC_URI="mirror://sourceforge/reoback/reoback-${PV/rc/r}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.6.1"
DEPEND=">=app-arch/tar-1.13"

S=${WORKDIR}/${PN}-${PV/_*}

src_unpack() {
	unpack ${A}
	find . -name CVS -type d | xargs rm -r
	cd "${S}"
	sed -i \
		-e '/^config=/s:=.*:=/etc/reoback/settings.conf:' \
		-e '/^reoback=/s:=.*:=/usr/sbin/reoback.pl:' \
		run_reoback.sh || die
}

src_install() {
	dosbin reoback.pl || die "dosbin"
	insinto /etc/reoback
	doins run_reoback.sh conf/* || die "doins conf"
	fperms 750 /usr/sbin/reoback.pl /etc/reoback/run_reoback.sh

	cd docs
	dodoc BUGS CHANGES INSTALL MANUALS README TODO
}
