# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/posh/posh-0.2.28.ebuild,v 1.1 2003/05/02 20:00:46 avenj Exp $

DESCRIPTION="posh is a stripped-down version of pdksh that aims for compliance with Debian's policy, and few extra features"
HOMEPAGE="http://packages.debian.org/posh"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/p/posh/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
S=${WORKDIR}/${P}

src_compile() {
	econf
	emake || die
}

src_install() {
	einstall bindir=${D}/bin
	dodoc BUG-REPORTS CONTRIBUTORS ChangeLog NEWS NOTES PROJECTS README
}
